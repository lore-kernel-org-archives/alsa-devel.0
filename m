From: Michael Downey <downey@zymeta.com>
Subject: hda-intel module hanging if ACPI enabled
Date: Thu, 29 Sep 2005 11:36:29 -0600
Message-ID: <433C261D.8090100@zymeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

I have an Intel Desktop D945GTP motherboard and I am running gentoo with 
kernel 2.6.13-r2.  If I enable ACPI then the system will hang whenever 
the hda-intel kernel module is loaded.  I did some more testing and I 
found that if I enable "Local APIC support for uniprocessors" and 
"IO-APIC support on uniprocessors" in the kernel then the hda-intel 
module will load when ACPI is enabled.  The codec that is used on the 
motherboard is a Sigmatel STAC9221 A1.  Is APIC a requirement for this 
setup?  Also I've tried 1.0.10rc1 of the alsa-driver and got the same 
results.

Also I was wondering how to go about retasking the audio jacks?  The 
default mixer only provides PCM, FRONT, CAPTURE, INPUT SELECT, and MIX.  
I would like to know how to set up 2 of the jacks to be output jacks 
which as far as I know is possible with hda-intel.

Thanks,


Michael Downey
Zymeta Corporation



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
