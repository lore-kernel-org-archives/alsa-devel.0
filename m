From: Gert Robben <lkml@gert.robben.nu>
Subject: Re: PROBLEM: snd-au8830: dead after software suspend
Date: Sat, 04 Aug 2007 02:51:44 +0200
Message-ID: <46B3CDA0.90804@gert.robben.nu>
References: <46B3A4F5.2000708@gert.robben.nu> <46B3C44D.7020801@gert.robben.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1762396AbXHDAvy@vger.kernel.org>
In-Reply-To: <46B3C44D.7020801@gert.robben.nu>
Sender: linux-kernel-owner@vger.kernel.org
To: alsa-devel@alsa-project.org
Cc: mjander@embedded.cl, linux-kernel@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

>>> Have you reported this to the ALSA people?
>> No, I thought this might as well be something for PCI or PM people, and 
>> I expected some ALSA people are also reading this list.
>> If not, where else should I report this exactly?
> alsa-devel [...] the author of the driver
Done (original message below). Thanks again :)

Gert Robben wrote:
> After a suspend-resume cycle (using Suspend2), my sound card doesn't 
> work anymore. It works again after reloading the module.
> 
> dmesg, initial boot:
>> Linux version 2.6.22-ck1
> ----8<----
>> PCI driver au8830 lacks driver specific resume support.
> 
> dmesg, after resume, trying to use the card:
>> vortex: ac97 codec stuck busy
> 
> Thanks for any help!
> 
> Gert Robben
