From: albox@free.fr
Subject: Re: Fwd: Problems with hda_intel, Santa Rosa,
	and suspend
Date: Fri, 29 Jun 2007 08:13:08 +0200
Message-ID: <1183097588.4684a2f4459df@imp.free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp5-g19.free.fr (smtp5-g19.free.fr [212.27.42.35])
	by alsa0.perex.cz (Postfix) with ESMTP id 245C12447B
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Jun 2007 07:13:09 +0200 (CEST)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: tiwai@suse.de
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Could this issue be related to the other one with Medion laptops :
https://bugtrack.alsa-project.org/alsa-bug/view.php?id=3160
Takashi, you said you were going to check the older patch that was working on
ALSA 1.0.13, did you have a chance to do that ?

Takashi Iwai wrote:
> At Mon, 25 Jun 2007 15:16:41 -0500,
> Matt Mullins wrote:
>> On 6/25/07, Takashi Iwai <tiwai@suse.de> wrote:
>>>> Yes, single_cmd mode is used always.
>>> That's bad.
>> I believe we have established that.  What can I do about it?  *Can* I
>> do anything about it?  What functions should I start debugging?  Has
>> this happened with other codecs before?  What documentation will I
>> need or want other than the Intel HDA and STAC9205 specifications?
>
> Similar problems have been seen in some laptops, too.  I vaguely
> remember that they need some ACPI-related boot options to fix it
> somehow.  I think it's likely irrelevant with the codec chip, but
> rather a problem of the controller side.
>
>> I'm definitely willing to help work on this, as not many people have
>> this hardware.  I'm just new to the sound system, so I'm still trying
>> to figure out what-calls-what.
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
>
