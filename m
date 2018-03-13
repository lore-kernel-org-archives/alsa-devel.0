From: Chris Obbard <chris@64studio.com>
Subject: Re: [linux-sunxi] Re: [PATCH v2 6/6] ASoC: sun4i-i2s: Add support for
 loopback
Date: Tue, 13 Mar 2018 13:39:44 +0000
Message-ID: <CAP03XeoaYcMrzv3+K83wGUaDn6ZcCDzePdVNcjAqJ4QrF-WLSA@mail.gmail.com>
References: <20180312155753.9478-1-codekipper@gmail.com>
 <20180312155753.9478-7-codekipper@gmail.com>
 <20180312183521.GP2186@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180312183521.GP2186@sirena.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: broonie@sirena.org.uk
Cc: alsa-devel@alsa-project.org, be17068@iperbole.bo.it, linux-kernel@vger.kernel.org, Chen-Yu Tsai <wens@csie.org>, lgirdwood@gmail.com, Code Kipper <codekipper@gmail.com>, linux-sunxi <linux-sunxi@googlegroups.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: alsa-devel@alsa-project.org

Hi Mark,

>
>> +- loopback:  if this property is present then the dai is configured in
>> +             loopback mode where the output fifo is redirected to the input
>> +             fifo.
>
> This really doesn't seem like something that ought to go into the DT
> and hence ABI given that there's obviously no reason to use this in
> production.  Just make it be a #define in the code or something.

It would be nice to have this as an optional devicetree property so
when testing JACK latency etc I don't have to manually re-compile a
kernel...
