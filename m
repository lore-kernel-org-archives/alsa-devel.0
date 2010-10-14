From: Raymond Yau <superquad.vortex2@gmail.com>
Subject: Re: [PATCH] ALSA: hda: Add speaker pin to automute
 Acer Aspire 8943G
Date: Thu, 14 Oct 2010 17:06:59 +0800
Message-ID: <AANLkTinkpg6emMGbUN59-VWO8J2OYzQhA07A=gtde7B1@mail.gmail.com>
References: <4CB68FC7.2060601@canonical.com> <4CB69FA4.9030702@gmail.com>
	<AANLkTimu4xyGTKPqV8hRRAthuraACrat9g4mmYpgHX5K@mail.gmail.com>
	<4CB6A57A.90101@gmail.com>
	<AANLkTim8aDvqXfHT9P+E_74mOCOuSMeQO4O1daht=dZm@mail.gmail.com>
	<4CB6C1F9.8000504@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-ew0-f51.google.com (mail-ew0-f51.google.com
	[209.85.215.51])
	by alsa0.perex.cz (Postfix) with ESMTP id 6018B103B40
	for <alsa-devel@alsa-project.org>;
	Thu, 14 Oct 2010 11:07:02 +0200 (CEST)
Received: by ewy9 with SMTP id 9so1895996ewy.38
	for <alsa-devel@alsa-project.org>; Thu, 14 Oct 2010 02:07:02 -0700 (PDT)
In-Reply-To: <4CB6C1F9.8000504@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

2010/10/14 Valentine Sinitsyn <valentine.sinitsyn@gmail.com>

> There are laptop which has 2.1 speakers which subwoofer is connected to
>> master mono pin of the STAC codec  , The ".1" subwoofer is most likely the
>> result of a Low pass filter attached to the mono pin
>>
> Maybe - I'm not pretending I've seen all possible configurations. Since the
> idea I'm discussing is to just add some new models for several laptops with
> subwoffers, ultimately it doesn't matter which pin has the subwoofer
> connected, it just have to be correct pin for a given laptop family (0x17
> for mine, whatever corresponds to Master Mono for someone else's etc).


https://bugtrack.alsa-project.org/alsa-bug/view.php?id=5031

The Dell XPS M1710 has 2.1 speakers with volume controls on both stereo
speakers and Subwoofer,

Node 0x11 [Pin Complex] wcaps 0x400104: Mono Amp-Out
  Amp-Out caps: N/A
  Amp-Out vals: [0x00]
  Pincap 0x00000010: OUT
  Pin Default 0x90170311: [Fixed] Speaker at Int N/A
    Conn = Analog, Color = Unknown
    DefAssociation = 0x1, Sequence = 0x1
    Misc = NO_PRESENCE
  Pin-ctls: 0x40: OUT
  Connection: 1
     0x13
