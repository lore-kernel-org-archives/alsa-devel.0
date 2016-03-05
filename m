From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Subject: Re: [PATCH 1/2] ASoC: cs35l32: avoid uninitialized variable access
Date: Sat, 5 Mar 2016 14:54:01 +0000
Message-ID: <20160305145400.GF19428@n2100.arm.linux.org.uk>
References: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1453741678-1988125-1-git-send-email-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Mark Brown <broonie@kernel.org>, Brian Austin <brian.austin@cirrus.com>, Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, Liam Girdwood <lgirdwood@gmail.com>, Paul Handrigan <Paul.Handrigan@cirrus.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org, linux-arm-kernel@lists.infradead.org
List-Id: alsa-devel@alsa-project.org

On Mon, Jan 25, 2016 at 06:07:32PM +0100, Arnd Bergmann wrote:
> gcc warns about the possibilty of accessing a property read from
> devicetree in cs35l32_i2c_probe() when it has not been initialized
> because CONFIG_OF is disabled:
> 
> sound/soc/codecs/cs35l32.c: In function 'cs35l32_i2c_probe':
> sound/soc/codecs/cs35l32.c:278:2: warning: 'val' may be used uninitialized in this function [-Wmaybe-uninitialized]
> 
> The code is actually correct because it checks the dev->of_node
> variable first and we know this is NULL here, but by adding a
> check for IS_ENABLED(CONFIG_OF), we can let the compiler know
> as well, and also generate smaller object code.

No, the code is buggy, and the compiler is very correct in warning about
it.

The code there is:

        of_property_read_u32(np, "cirrus,boost-manager", &val);
        switch (val) {

of_property_read_u32() is aliased to of_property_read_u32_array() via:

static inline int of_property_read_u32(const struct device_node *np,
                                       const char *propname,
                                       u32 *out_value)
{
        return of_property_read_u32_array(np, propname, out_value, 1);
}

which does this:

int of_property_read_u32_array(const struct device_node *np,
                               const char *propname, u32 *out_values,
                               size_t sz)
{
        const __be32 *val = of_find_property_value_of_size(np, propname,
                                                (sz * sizeof(*out_values)));

        if (IS_ERR(val))
                return PTR_ERR(val);

        while (sz--)
                *out_values++ = be32_to_cpup(val++);
        return 0;
}

Note that 'out_values' is not written to if of_find_property_value_of_size()
returns an error.  Therefore, if cirrus,boost-manager is missing, the
resulting value of 'val' is left uninitialised.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
