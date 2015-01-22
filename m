From: "Lu, Han" <han.lu@intel.com>
Subject: Re: [PATCH - UCM 1/1] ucm: add binary configure file
 parse
Date: Thu, 22 Jan 2015 01:54:47 +0000
Message-ID: <B51200AC81AB024499A3C2C9A1BB90A8343DAD@SHSMSX101.ccr.corp.intel.com>
References: <1421805316-3070-1-git-send-email-han.lu@intel.com>
 <s5hoaprvr7j.wl-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 by alsa0.perex.cz (Postfix) with ESMTP id 980A3260586
 for <alsa-devel@alsa-project.org>; Thu, 22 Jan 2015 02:54:52 +0100 (CET)
In-Reply-To: <s5hoaprvr7j.wl-tiwai@suse.de>
Content-Language: en-US
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "Girdwood,
 Liam R" <liam.r.girdwood@intel.com>
List-Id: alsa-devel@alsa-project.org

Hi Takashi,

BR,
Han Lu

> -----Original Message-----
> From: Takashi Iwai [mailto:tiwai@suse.de]
> Sent: Thursday, January 22, 2015 4:01 AM
> To: Lu, Han
> Cc: alsa-devel@alsa-project.org; Girdwood, Liam R
> Subject: Re: [alsa-devel] [PATCH - UCM 1/1] ucm: add binary configure file
> parse
> 
> At Wed, 21 Jan 2015 09:55:16 +0800,
> han.lu@intel.com wrote:
> >
> > From: "Lu, Han" <han.lu@intel.com>
> >
> > with cset command, UCM set kcontrol parameters directly:
> >     cset "name='<KCONTROL_NAME>' 1<,2,3,...>"
> > This patch enables UCM to set kcontrol with parameters from configure
> > file:
> >     cset-bin-file "name='<KCONTROL_NAME>' <path/to/file>"
> > where "cset-bin-file" is a newly added keyword alongside of "cset", to
> > indicate cset with binary data in file.
> > The binary data in file is parameter for audio DSPs, and it's just
> > passed by UCM/ALSA as raw data. The data type of parameter elements
> > must be byte, and the count must matches driver definition.
> >
> > Signed-off-by: Lu, Han <han.lu@intel.com>
> 
> The contents are almost good, but I got a few compile warnings.
> 
> ================
> main.c: In function 'binary_file_parse':
> main.c:185:2: warning: implicit declaration of function 'stat' [-Wimplicit-
> function-declaration]
>   if (stat(filepath, &st) == -1) {
>   ^
> main.c:201:24: warning: comparison between signed and unsigned integer
> expressions [-Wsign-compare]
>   if (read(fd, res, sz) != sz) {
>                         ^
> main.c: In function 'execute_sequence':
> main.c:252:5: warning: 'err' may be used uninitialized in this function [-
> Wmaybe-uninitialized]
>   if (err < 0)
>      ^
> main.c:285:6: note: 'err' was declared here
>   int err = 0;
>       ^
> ================
> 

Sorry, I didn't find the warnings. I have sent the modified patch.
BTW, with -Wall/-Wimplicit-function-declaration, I can find warning 1; and with -Wsign-compare I can find warning 2; but with -Wmaybe-uninitialized I cannot find warning 3. (although I did ignore initialization in binary_file_parse(), not execute_sequence())
My platform is Ubuntu 12.10 with gcc-4.9.1, and for alsa-lib.git I used default compile settings. Could you please share your compile setting if convenient? Thanks.

> 
> Takashi
