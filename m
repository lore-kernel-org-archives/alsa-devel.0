From: "naveen krishna ch" <naveenkrishna.ch@gmail.com>
Subject: Re: ASoC, TWL4030 Register defaults
Date: Thu, 20 Nov 2008 17:21:11 +0530
Message-ID: <ef0d8a250811200351x3d18ea1fm58e9dac3613aeea9@mail.gmail.com>
References: <ef0d8a250811200319kd1afdf8r74d09d54e37b830c@mail.gmail.com>
	<20081120112304.GB4539@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by alsa0.perex.cz (Postfix) with ESMTP id 3B91F24179
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 12:51:13 +0100 (CET)
Received: by rn-out-0910.google.com with SMTP id j67so456174rne.21
	for <alsa-devel@alsa-project.org>; Thu, 20 Nov 2008 03:51:11 -0800 (PST)
In-Reply-To: <20081120112304.GB4539@sirena.org.uk>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@sirena.org.uk>
Cc: alsa-devel@alsa-project.org, Steve Sakoman <steve@sakoman.com>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 20, 2008 at 4:53 PM, Mark Brown <broonie@sirena.org.uk> wrote:

> On Thu, Nov 20, 2008 at 04:49:33PM +0530, naveen krishna ch wrote:
>
> > [PATCH] Register default values for gain, path selection for various
> input
> > and output devices
> > From:
> > chnaveenkrishna <chnaveen@chnaveen.mistral.in>
> >   To:
> > Date:
> > Today 04:49:50 pm
>
> Something (your MUA)?  Is mangling this really badly...

Sorry i will try avoiding this MUA issue, I was using the gmail till now.

>
>
> As I said in reply to your first mail I'd really like to see some sort
> of explanation as to why you are making these changes - are the defaults
> in the existing driver wrong?  There seem to be an awful lot of changes
> here and there's no discussion in the patch as to what they mean.

The existing driver does the default settings for only one input device
(Line in) and one output device (Headset out).
The CODEC supports 5 output devices and 4 input devices.

The default values given by the drivers author are according to his custom
requirements, expanding them to the CODEC's ability these values can be
modified.

What all this patch is doing is setting the default playback and capture
volumes of various input and output devices to reasonable values.

-       0x24, /* REG_ANAMICL            (0x5)   */
-       0x04, /* REG_ANAMICR            (0x6)   */
+       0xb0, /* REG_ANAMICL            (0x5)   */
+       0x10, /* REG_ANAMICR            (0x6)   */
Author is setting default capture device as Line In.  It was modified to
none.

-       0x4b, /* REG_ARXL2_APGA_CTL     (0x1B)  */
-       0x4b, /* REG_ARXR2_APGA_CTL     (0x1C)  */
+       0x2b, /* REG_ARXL2_APGA_CTL     (0x1B)  */
+       0x2b, /* REG_ARXR2_APGA_CTL     (0x1C)  */
The gain controls register settings now modified for minimal play back
volume.

-       0x00, /* REG_EAR_CTL            (0x21)  */
-       0x24, /* REG_HS_SEL             (0x22)  */
-       0x0a, /* REG_HS_GAIN_SET        (0x23)  */
+       0x20, /* REG_EAR_CTL            (0x21)  */
+       0x00, /* REG_HS_SEL             (0x22)  */
+       0x05, /* REG_HS_GAIN_SET        (0x23)  */

He selected the Headset as default output device it was modified to none
with some gain settings.

-       0x00, /* REG_PREDL_CTL          (0x25)  */
-       0x00, /* REG_PREDR_CTL          (0x26)  */
-       0x00, /* REG_PRECKL_CTL         (0x27)  */
-       0x00, /* REG_PRECKR_CTL         (0x28)  */

+       0x20, /* REG_PREDL_CTL          (0x25)  */
+       0x20, /* REG_PREDR_CTL          (0x26)  */
+       0x20, /* REG_PRECKL_CTL         (0x27)  */
+       0x20, /* REG_PRECKR_CTL         (0x28)  */
GVain settings for 3 outputting devices

-       0x00, /* REG_HFL_CTL            (0x29)  */
-       0x00, /* REG_HFR_CTL            (0x2A)  */
+       0x1f, /* REG_HFL_CTL            (0x29)  */
+       0x1f, /* REG_HFR_CTL            (0x2A)  */
gain settings and path selection for handsfree output

-       0x00, /* REG_ANAMIC_GAIN        (0x48)  */
+       0x24, /* REG_ANAMIC_GAIN        (0x48)  */
Main and Sub Mic gain settings.


My upcoming patches will make use of this default settings.


-- 
Thanks,

(: Naveen Krishna Ch :)
