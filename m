From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Question about snd_soc_add_controls
Date: Mon, 21 Jun 2010 10:41:31 +0100
Message-ID: <B0E1ACA6-F554-4C10-A21A-EDB9F15ED324@opensource.wolfsonmicro.com>
References: <w3pfx0gn3p3.wl%kuninori.morimoto.gx@renesas.com>
	(sfid-20100621_101934_757691_406BA2F7)
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 40AE224542
	for <alsa-devel@alsa-project.org>;
	Mon, 21 Jun 2010 11:41:33 +0200 (CEST)
In-Reply-To: <w3pfx0gn3p3.wl%kuninori.morimoto.gx@renesas.com>
	(sfid-20100621_101934_757691_406BA2F7)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: Linux-ALSA <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 21 Jun 2010, at 10:19, Kuninori Morimoto wrote:

> But I wonder
> #define DECLARE_TLV_DB_SCALE(name, min, step, mute)
> 
> Does this "mute" mean that it can use mute ?
> But how to ?

In many chips the lowest gain setting is defined as mute rather than
a dB value. Setting the mute flag indicates that this is the case for
this gain control.

> #define SOC_DOUBLE_R_TLV(xname, reg_left, reg_right, xshift, xmax, xinvert, tlv_array)

> What is this "xinvert" ?

It means that instead of the lowest register value being the lowest
volume the highest register value is the lowest volume. This is used
to ensure the control is mapped properly in userspace so sliders
raise the volume when moved upwards. 

> Can you please teach me about above ?
> And where is these code used ?
> It seems very complex for me...

See the functions that are specified in the macro - these values are
used to generate ALSA controls for the specified bitfields.
