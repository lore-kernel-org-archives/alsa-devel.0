From: Apostolos Dimitromanolakis <apostolos@aei.ca>
Subject: Re: writing user program for alsa under fedora core
 1
Date: Sat, 29 May 2004 23:09:31 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <40B9506B.2040507@aei.ca>
References: <FDEHJOEHEEGCJHLBEHMFGEOBCAAA.fwmiller@cornfed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-7; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <FDEHJOEHEEGCJHLBEHMFGEOBCAAA.fwmiller@cornfed.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Frank W. Miller" <fwmiller@cornfed.com>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The Fedora Core should have some RPM with the ALSA header files.  Since 
it is not installed, try looking in the CDs with whatever tool Fedora 
provides for searching the RPMS.  From a quick look at the names of the 
RPMS I cannot find where the ALSA header files are but since I do not 
run Fedora I can't help you further.  If it is nowhere then it is a 
problem/bug w/the Fedora and not your fault.

Apostolos

Frank W. Miller wrote:

>Thanks for the reply...
>
>I probably need to be more specific here.  I have a driver that works well
>with OSS under Red Hat 9.  When I reinstalled my system using Fedora Core 1,
>I did not need OSS any more.  I have nice sound coming from my speakers
>using ALSA.  When I try to run my existing binary that makes OSS calls on
>top of Fedora that is using an ALSA driver for my soundcard, I get some
>strange behaviour, some of the calls don't work the same.  For example, the
>card supports full-duplex but the ALSA driver seems to think it will only
>support half-duplex.  When I try to set the sampling rate on the 16-bit
>interface, I get an error (cant remember which one right now).  So my
>thought was, especially after reading the docs, i.e. the HOWTO-0.9 or
>something like that, that I should just rewrite the driver to make ALSA type
>calls.  That's when I discovered that I dont have this header file.
>
>So, I obviously have a working ALSA subsystem, since my soundcard works with
>the CD player for example.  All I really need to do is get to a place where
>I can write a program making ALSA API calls.  Thats what I need help to do.
>Now, is it really necessary for me download all the source and rebuild it
>and all that to accomplish this task?
>
>Thanks,
>FM
>
>
>  
>



-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
