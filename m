From: Michael Downey <downey@zymeta.com>
Subject: Re: hda-intel module hanging if ACPI enabled
Date: Thu, 29 Sep 2005 12:13:49 -0600
Message-ID: <433C2EDD.4050005@zymeta.com>
References: <433C261D.8090100@zymeta.com> <20050929105612.A8457@cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050929105612.A8457@cox.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Matt Porter wrote:

>On Thu, Sep 29, 2005 at 11:36:29AM -0600, Michael Downey wrote:
>  
>
>>I have an Intel Desktop D945GTP motherboard and I am running gentoo with 
>>kernel 2.6.13-r2.  If I enable ACPI then the system will hang whenever 
>>the hda-intel kernel module is loaded.  I did some more testing and I 
>>found that if I enable "Local APIC support for uniprocessors" and 
>>"IO-APIC support on uniprocessors" in the kernel then the hda-intel 
>>module will load when ACPI is enabled.  The codec that is used on the 
>>motherboard is a Sigmatel STAC9221 A1.  Is APIC a requirement for this 
>>setup?  Also I've tried 1.0.10rc1 of the alsa-driver and got the same 
>>results.
>>    
>>
> 
>I hadn't noticed this myself since I have local apic support on in
>my kernel, but have heard the same thing from other users. Haven't
>looked into it further yet.
>
>  
>
>>Also I was wondering how to go about retasking the audio jacks?  The 
>>default mixer only provides PCM, FRONT, CAPTURE, INPUT SELECT, and MIX.  
>>I would like to know how to set up 2 of the jacks to be output jacks 
>>which as far as I know is possible with hda-intel.
>>    
>>
>
>I am working on some updates to the SigmaTel HDA patch to support these
>motherboards. The basic issue is that the BIOS doesn't set up the
>proper configuration default registers on these motherboards so we
>need to detect the motherboard and load the proper configuration
>defaults. I also added in some switches to retask those jacks.
>
>I have an issue with my boards in that they don't properly reflect
>the Subsystem ID that should be used for identifying the motherboard
>and jack configuration.  Can you do a
>'grep Subsystem /proc/asound/card0/codec#2' and post the results?
>I'd like to verify that your board shows the proper ID.
>
>-Matt
>  
>
Thanks for the quick reply. Here's my output:
Subsystem Id: 0x0

The board has a BIOS revision string of: 
NT9410J.86A.1348.2005.0609.1737. I see that there is a newer BIOS 2104 
released on Sept. 2 so updating the BIOS might make a difference. I will 
probably try the update in a day or two so I'll post my results then.

Michael Downey
Zymeta Corporation



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
