From: frankgaetano@collegeclub.com
Subject: Re: Hammerfall DSP System Problems
Date: Thu, 5 Jun 2003 19:56:23 -0400 (EDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <7658093.1054857383640.JavaMail.java@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_11_7788130.1054857383629"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: PaulDavis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

------=_Part_11_7788130.1054857383629
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Paul,
 Thanks for responding. I am using the current CVS of Alsa version 0.9.4. 

Frank

Paul Davis <paul@linuxaudiosystems.com> wrote:

>> I recently purchased a Hammerfall DSP system to use on Windows and 
>>especially LINUX for use on Ardour. I have the multiface system. I 
>>must say I am confused on the support of the newest version of this 
>>pci card (I know that I have firmware version 11). I downloaded the 
>>current CVS on alsa-dev and compiled it fine. However when I run 
>>modprobe I get the following error: 
>
>there are a number problems with the hdsp driver at present. fixing
>
>them is mostly a matter of at least 1 of 3 people finding time to work
>
>on it. however, your initial problems are different:
>
> 
>>Using /lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o 
>>/lib/modules/2.4.18-3/kernel/sound/pci/rme9652/snd-hdsp.o: unresolved 
>>symbol snd_hammerfall_get_buffer_R5bab1fdf 
>
>you don't have a version of the ALSA drivers compiled in a way that
>
>will allow the kernel module system to work. you need to fix this
>
>first. someone else will have to comment on how to do that. you should
>
>probably specify which version of ALSA you are using since there are
>
>many changes to ALSA all the time. it appears to me that you may have
>
>a version of ALSA that doesn't build the rawmidi module that the hdsp
>
>requires to support it. 
>
>--p
>
>
>
>-------------------------------------------------------
>
>This SF.net email is sponsored by: Etnus, makers of TotalView, The best
>
>thread debugger on the planet. Designed with thread debugging features
>
>you've never dreamed of, try TotalView 6 free at www.etnus.com.
>
>_______________________________________________
>
>Alsa-devel mailing list
>
>Alsa-devel@lists.sourceforge.net
>
>https://lists.sourceforge.net/lists/listinfo/alsa-devel
>
>
>



-------------------------------------------------------------------------- 
Looking for a roommate? Let CollegeClub.com help you out!
<http://navisite.collegeclub.com/channels/college/>

CollegeClub.com makes college life even better.
------=_Part_11_7788130.1054857383629--



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
