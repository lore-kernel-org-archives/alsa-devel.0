From: =?ISO-8859-1?Q?Ren=E9_Rebe?= <rene@rocklinux-consulting.de>
Subject: Re: [Alsa-user] alsa-1.0.6
Date: Mon, 16 Aug 2004 14:04:58 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <4120A2EA.8010006@rocklinux-consulting.de>
References: <20040816.122326.74756645.Meino.Cramer@gmx.de> <Pine.LNX.4.53.0408161229110.23861@yvahk01.tjqt.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.53.0408161229110.23861@yvahk01.tjqt.qr>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

Jan Engelhardt wrote:

>>Taking a look at the frist message I found in asound.h the following
>>piece of code:
>>
>>
>>struct sndrv_hwdep_dsp_image {
>>	unsigned int index;		/* W: DSP index */
>>	unsigned char name[64];		/* W: ID (e.g. file name) */
>>	unsigned char __user *image;	/* W: binary image */  !!!!!!!!!!
>>	size_t length;			/* W: size of image in bytes */
>>	unsigned long driver_data;	/* W: driver-specific data */
>>};
>>
>>
>>"!!!!!!" marks the line, in which gcc 3.3.4 fails.
>>
>>Is it due to that "__user" ?
> 
> 
> From a programmer's point of view, I would say look up where __user is defined.
> If not, just try removing __user.

linux/compiler.h

Either ALSA is compiler against the wrong kernel headers (outdated, e.g. 
2.4) or a #include <linux/compiler.h> is missing ;-)

Sincerely yours,
   René Rebe

--
René Rebe - Europe/Germany/Berlin
   rene@rocklinux.org rene@rocklinux-consulting.de
http://www.rocklinux.org http://www.rocklinux-consulting.de


-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
