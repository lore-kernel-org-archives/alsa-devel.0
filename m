From: Robert Hancock <hancockr@shaw.ca>
Subject: Re: a7839e96 (PNP: increase max resources) breaks my ALSA intel8x0
 sound card
Date: Thu, 31 Jan 2008 18:14:03 -0600
Message-ID: <47A2644B.4000905@shaw.ca>
References: <fa.Kmpf0B4W44W1VefIME7+BnfUouY@ifi.uio.no>
 <479CCAAD.4080706@shaw.ca> <20080131145820.44171af2.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S965236AbYBAAOk@vger.kernel.org>
In-reply-to: <20080131145820.44171af2.akpm@linux-foundation.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: avuton@gmail.com, yakui.zhao@intel.com, shaohua.li@intel.com, bjorn.helgaas@hp.com, trenn@suse.de, torvalds@linux-foundation.org, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Andrew Morton wrote:
>> There was a patch floating around to ignore PnPACPI reservations which 
>> conflict with PCI BARs, which appears to be what's happening in this 
>> case. That patch originally worked for any board, but was later made 
>> specific to a certain Supermicro motherboard which had the sata_nv 
>> controller MMIO regions marked as reserved, preventing the driver from 
>> loading. We may need a more general solution. See:
>>
>> https://bugzilla.redhat.com/show_bug.cgi?id=313491
> 
> Thanks.  If we were to remove the supermicro-specificity, would this be a
> sufficiently general solution?

I think so. There was one objection that it introduced a dependency on 
pnpacpi loading after PCI bus enumeration, though.

Linus also suggested that pnpacpi could be marking the resources as 
"present but unused" so that drivers can request those regions but we 
still prevent dynamically assigning resources into them.
