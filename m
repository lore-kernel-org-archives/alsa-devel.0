From: Stefan Krastanov <krastanov.stefan@gmail.com>
Subject: Re: alc889
Date: Tue, 23 Jun 2009 00:54:15 +0200
Message-ID: <cb66509f0906221554n1c38674by6df8cdd086c3b243@mail.gmail.com>
References: <cb66509f0906200559o764a06e8i714cfd08ee908575@mail.gmail.com>
	<s5h7hz4cjhl.wl%tiwai@suse.de>
	<cb66509f0906221505r79950d30i73d1cdd4d0910e45@mail.gmail.com>
	<s5heitbewqx.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-bw0-f215.google.com (mail-bw0-f215.google.com
	[209.85.218.215])
	by alsa0.perex.cz (Postfix) with ESMTP id 85AB8246B8
	for <alsa-devel@alsa-project.org>;
	Tue, 23 Jun 2009 00:54:16 +0200 (CEST)
Received: by bwz11 with SMTP id 11so3692986bwz.32
	for <alsa-devel@alsa-project.org>; Mon, 22 Jun 2009 15:54:15 -0700 (PDT)
In-Reply-To: <s5heitbewqx.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

With model=fujitsu-pi2515
    - jack sensing works (great!!!)
    - still no control over sub-woofer
    - there is some noise, but maybe is just the quality of my hardware

with model=fujitsu-xa3530
    - no jack sensing
    - the mixers are really mixed up - one slider controls one side of front
speakers and other side of headphones
    - there is some(not sure) control over sub-woofer volume

when I was using 3-stack-dig there were two slider (LFE and another one)
that booth controlled the sub-woofer and there was third - "side" that was
not controlling anything.

If there is a way to add a sub-woofer control to fujitsu-pi2515 it would be
great - if it's too much too ask from you to do it, can you tell me where to
start looking for a documented way to create a patch for a new type of
model? (fujitsu-xi for example as it's the model of my laptop) I'm allready
reading the other docs that you told me about.

Best regadrs
Stefan Krastanov

2009/6/23 Takashi Iwai <tiwai@suse.de>

> At Tue, 23 Jun 2009 00:05:42 +0200,
> Stefan Krastanov wrote:
> >
> > Hello,
> >
> > Thank you for your fast response, I appreciate it, knowing you don't have
> all
> > that free time.
> >
> > As I have said my hardware configuration is: laptop with alc889 soundcard
> >                                                                    - two
> front
> > speakers
> >                                                                    - one
> > sub-woofer
> >                                                                    - one
> > internal microphone
> >                                                                    -
> jacks
> > with jacksensing (tested on windows) - mic, line-in, headphones
> >                                                                    -
> digital
> > IO
> >                                                                    -
> > potentiometer for volume control
> >
> > I installed the latest snapshot using ubuntu's automated script (I
> manually
> > verified that it's the latest) and used model=auto. The results were the
> same
> > when I tried it few months ago:
> >    - "Front" controls the front speakers                            OK
> >    - "Front" also controls headphones
> problem
> >    - "Headphones" slider does not control anything           problem
> >    - No control slider for the build-in sub-woofer                problem
> >    - microphones working (external and internal)               OK
> >    - potentiometer for volume control not working             problem
> >    - Line-in not tested, digital IO not tested                      not
> tested
> >    - jack sensing on the headphones is not working          problem
> >    - jack sensing on microphone and line in not tested      not tested
> >
> > Attached to the message you can find the output from alsa-info.
>
> Hm, how about model=fujitsu-pi2515 or model=fujitsu-xa3530 option?
> Just a wild guess from the PCI SSID, though.
>
>
> Takashi
>
