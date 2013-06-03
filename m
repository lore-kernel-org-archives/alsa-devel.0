From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [PATCH 2/8] add device specific command
Date: Mon, 03 Jun 2013 13:18:27 +0200
Message-ID: <51AC7B83.3060708@ladisch.de>
References: <1370102158-24389-1-git-send-email-o-takashi@sakamocchi.jp>
	<1370102158-24389-3-git-send-email-o-takashi@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux1394-devel-bounces@lists.sourceforge.net>
In-Reply-To: <1370102158-24389-3-git-send-email-o-takashi@sakamocchi.jp>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux1394-devel>
List-Post: <mailto:linux1394-devel@lists.sourceforge.net>
List-Help: <mailto:linux1394-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux1394-devel>,
	<mailto:linux1394-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux1394-devel-bounces@lists.sourceforge.net
To: o-takashi@sakamocchi.jp
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, linux1394-devel@lists.sourceforge.net, ffado-devel@lists.sf.net, perex@perex.cz
List-Id: alsa-devel@alsa-project.org

o-takashi@sakamocchi.jp wrote:
> Fireworks can be controlled by device specific commands over IEEE1394 TA's
> AV/C Digital Interface Command Set.

It can also be controlled by sending the commands directly (without the
AV/C header) to address 0xecc000000000.  This is one of the differences
between FFADO and the Echo drivers, and might be related to the problems
that FFADO has with the latest Fireworks firmware versions.

Do you have the latest firmware in your AFPre8?

> +struct avc_fields {
> +	unsigned short cts:4;
> +	unsigned short ctype:4;
>       ...

The layout of bit fields are very unportable.  And if you do *not*
actually rely on the memory layout, you do not actually save space
because the code to access the fields becomes more complex.

> +efc_over_avc(struct snd_efw *efw, unsigned int category,

> +	/* AV/C fields */
> +	struct avc_fields avc_fields = {
> +		.cts		= AVC_CTS,
> +		.ctype		= AVC_CTYPE,
> +		.subunit_type	= AVC_SUBUNIT_TYPE,
> +		.subunit_id	= AVC_SUBUNIT_ID,
> +		.opcode		= AVC_OPCODE,
> +		.company_id	= AVC_COMPANY_ID
> +	};

The compiler has to construct this on the stack.  Use "static const".

> +	/* calcurate buffer size*/

           calculate

> +	if (param_count > response_quadlets)
> +		cmdbuf_bytes = 32 + param_count * 4;
> +	else
> +		cmdbuf_bytes = 32 + response_quadlets * 4;

max()

> +int snd_efw_command_identify(struct snd_efw *efw)
> +{
> +	return efc_over_avc(efw, EFC_CAT_HWCTL,
> +				EFC_CMD_HWCTL_IDENTIFY,

That was part of my old driver, but most if this device-specific stuff
is not needed for a simple kernel streaming driver.


Regards,
Clemens

------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite
It's a free troubleshooting tool designed for production
Get down to code-level detail for bottlenecks, with <2% overhead.
Download for free and get started troubleshooting in minutes.
http://p.sf.net/sfu/appdyn_d2d_ap2
