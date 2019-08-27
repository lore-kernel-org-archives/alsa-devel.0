From: Kai-Heng Feng <kai.heng.feng@canonical.com>
Subject: Re: [PATCH 1/2] PCI: Add a helper to check Power Resource
 Requirements _PR3 existence
Date: Wed, 28 Aug 2019 00:58:28 +0800
Message-ID: <0379E973-651A-442C-AF74-51702388F55D@canonical.com>
References: <20190827134756.10807-1-kai.heng.feng@canonical.com>
 <s5hr2567hrd.wl-tiwai@suse.de>
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Content-Type: text/plain;
        charset=us-ascii;
        delsp=yes;
        format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <s5hr2567hrd.wl-tiwai@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Takashi Iwai <tiwai@suse.de>
Cc: bhelgaas@google.com, alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
List-Id: alsa-devel@alsa-project.org

at 23:25, Takashi Iwai <tiwai@suse.de> wrote:

> On Tue, 27 Aug 2019 15:47:55 +0200,
> Kai-Heng Feng wrote:
>> A driver may want to know the existence of _PR3, to choose different
>> runtime suspend behavior. A user will be add in next patch.
>>
>> This is mostly the same as nouveau_pr3_present().
>
> Then it'd be nice to clean up the nouveau part, too?

nouveau_pr3_present() may call pci_d3cold_disable(), and my intention is to  
only check the presence of _PR3 (i.e. a dGPU) without touching anything.

Kai-Heng

>
>
> thanks,
>
> Takashi
