From: Daniel Mack <zonque@gmail.com>
Subject: Re: MAYA44 USB audio device no inputs control
Date: Tue, 22 Nov 2011 17:35:30 +0100
Message-ID: <4ECBCF52.8020907@gmail.com>
References: <CAB+hzYRC+_RDBwiakNq7PJ=_7xyrFhTdNuoYAGyyq093s0mp0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-qw0-f44.google.com (mail-qw0-f44.google.com
	[209.85.216.44])
	by alsa0.perex.cz (Postfix) with ESMTP id BED1E103A84
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 17:35:39 +0100 (CET)
Received: by qadb14 with SMTP id b14so1682594qad.17
	for <alsa-devel@alsa-project.org>; Tue, 22 Nov 2011 08:35:39 -0800 (PST)
In-Reply-To: <CAB+hzYRC+_RDBwiakNq7PJ=_7xyrFhTdNuoYAGyyq093s0mp0A@mail.gmail.com>
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
List-Id: alsa-devel@alsa-project.org

On 11/22/2011 05:33 PM, Kamil Sobolak wrote:
> Hi!
> In our Youth Polish Radio we are using MAYA44 USB sound device, with JACK
> and Internet DJ Console (IDJC) to make lives show.
> On PC is Ubuntu 11.04 with alsa v1.0.24 and alsamixer but ther is no input
> control.
> 
>> ALSA: ice1724 - Fix ESI Maya44 capture source control
> 
> 
> But this doesn't work. Now after contact with Takashi Iwai I know this
> entry is for PCI sound card version not USB.

Send us your output of 'lsusb -v', please.

What kind of input control would you expect there to be, and why?
