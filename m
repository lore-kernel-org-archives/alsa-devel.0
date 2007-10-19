From: Matthew Ranostay <mranostay@embeddedalley.com>
Subject: Re: [PATCH] hda: Add dmux to STAC 9228
Date: Fri, 19 Oct 2007 13:59:14 -0400
Message-ID: <4718F072.9060007@embeddedalley.com>
References: <4717D1E0.9080903@embeddedalley.com> <4718DF33.501@canonical.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------030806060906090006080606"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp100.biz.mail.re2.yahoo.com (smtp100.biz.mail.re2.yahoo.com
	[206.190.52.46]) by alsa0.perex.cz (Postfix) with SMTP id CD5DA24646
	for <alsa-devel@alsa-project.org>;
	Fri, 19 Oct 2007 19:59:26 +0200 (CEST)
In-Reply-To: <4718DF33.501@canonical.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Tim Gardner <tim.gardner@canonical.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, "Tellman,
	Steven" <Steven.Tellman@idt.com>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------030806060906090006080606
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Tim Gardner wrote:
> Matthew Ranostay wrote:
>   
>> Added a dmux to the STAC9228 cards with DMIC support. And added a
>> STAC_DIGITAL_INPUT_SOURCE macro for repeating mixer code.
>> ---
>>     
>
> I'm not having any luck with this patch on my XPS M1330. I built against
> Ubuntu Gutsy (2.6.22 which requires some PIT_TICK_RATE futzing in
> pcsp.h) from current ALSA repo bits after Takashi applied it to HG. I
> also removed Gusty l-u-m which contains a conflicting snd-hda-intel.
>
> Audio output works fine. The only record source that appears to work is
> the external microphone (front input), though it is very faint even with
> mux 1 cranked to the max.
>
> Can you describe your environment and record applications? Perhaps I'm
> just missing some assumption.
>
>   
I think the problem is that I set the dmux to ADC1MUX instead of 
ADC0MUX, could you test this patch to confirm?
Please let me know your results.

Thanks,

Matt Ranostay

--------------030806060906090006080606
Content-Type: text/plain; x-mac-type="0"; x-mac-creator="0";
 name="stac9228_dmux_correction.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="stac9228_dmux_correction.patch"

diff -r 7cf5e23f804e pci/hda/patch_sigmatel.c
--- a/pci/hda/patch_sigmatel.c	Fri Oct 19 08:23:00 2007 +0200
+++ b/pci/hda/patch_sigmatel.c	Fri Oct 19 13:47:35 2007 -0400
@@ -2777,7 +2777,7 @@ static int patch_stac927x(struct hda_cod
 	case 0x10280209: /* STAC 9228 */
 		spec->dmic_nids = stac927x_dmic_nids;
 		spec->num_dmics = STAC927X_NUM_DMICS;
-		spec->dmux_nid = 0x1c;
+		spec->dmux_nid = 0x1b;
 		break;
 	default:
 		spec->num_dmics = 0;	

--------------030806060906090006080606
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------030806060906090006080606--
