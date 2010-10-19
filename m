From: Victor Rodriguez <vm.rod25@gmail.com>
Subject: Re: [PATCH v4 7/9] davinci: MMC/SD support for
	Omapl138-Hawkboar
Date: Mon, 18 Oct 2010 20:50:56 -0500
Message-ID: <AANLkTint2jQ3NpNWk09Y+Tm-mqAaUHpteZ+wrRA_3CDA@mail.gmail.com>
References: <AANLkTin-DH9eU9wSPLROVBbMj=gfxjRH=Jz=b4yUuHfi@mail.gmail.com>
	<70E876B0EA86DD4BAF101844BC814DFE093EEAB44E@Cloud.RL.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-iw0-f179.google.com (mail-iw0-f179.google.com
	[209.85.214.179])
	by alsa0.perex.cz (Postfix) with ESMTP id 9AD99103904
	for <alsa-devel@alsa-project.org>;
	Tue, 19 Oct 2010 03:50:57 +0200 (CEST)
Received: by iwn9 with SMTP id 9so2085083iwn.38
	for <alsa-devel@alsa-project.org>; Mon, 18 Oct 2010 18:50:56 -0700 (PDT)
In-Reply-To: <70E876B0EA86DD4BAF101844BC814DFE093EEAB44E@Cloud.RL.local>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Jon Povey <Jon.Povey@racelogic.co.uk>
Cc: "davinci-linux-open-source@linux.davincidsp.com" <davinci-linux-open-source@linux.davincidsp.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Mon, Oct 18, 2010 at 8:16 PM, Jon Povey <Jon.Povey@racelogic.co.uk> wrote:
> davinci-linux-open-source-bounces@linux.davincidsp.com wrote:
>> I think that you mean that I should not call gpio_direction_input if
>> gpio_request failed am I right ?
>
> Yes, if gpio_request() fails that means you have not claimed that gpio,
> something else is using it already or it's not available due to other
> misconfiguration.
>
> So you shouldn't be trying to set its direction or anything like that.
>
> --
> Jon Povey
> jon.povey@racelogic.co.uk
>
> Racelogic is a limited company registered in England. Registered number 2743719 .
> Registered Office Unit 10, Swan Business Centre, Osier Way, Buckingham, Bucks, MK18 1TB .
>
> The information contained in this electronic mail transmission is intended by Racelogic Ltd for the use of the named individual or entity to which it is directed and may contain information that is confidential or privileged. If you have received this electronic mail transmission in error, please delete it from your system without copying or forwarding it, and notify the sender of the error by reply email so that the sender's address records can be corrected. The views expressed by the sender of this communication do not necessarily represent those of Racelogic Ltd. Please note that Racelogic reserves the right to monitor e-mail communications passing through its network
>
>
>

Hi Jon

Yes you are right and as I understand gpio_request will give a 0 if it
success and because of that the warning never will appear, if there is
a problem there will be a -1 and the warning will be printed. I could
fix this with a return that breaks the code like this

       ret = gpio_request(DA850_HAWK_MMCSD_CD_PIN, "MMC CD\n");
       if (ret) {
               pr_warning("%s: can not open GPIO %d\n",
                       __func__, DA850_HAWK_MMCSD_CD_PIN);
               return;
       }
       gpio_direction_input(DA850_HAWK_MMCSD_CD_PIN);

Is this ok ?

Thanks

Sincerely yours

Victor Rodriguez
