From: Edward Muller <edwardam@interlix.com>
Subject: Re: Re: [Alsa-devel] Redhat 9.0 also has the snd.o
	unresolved symbol schedule_work issue
Date: 02 Apr 2003 17:55:46 -0600
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1049327746.7122.4.camel@localhost.localdomain>
References: <3E861CFC.9040908@corekin.no-ip.com>
	 <1049062787.3017.22.camel@jason.corekin>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <1049062787.3017.22.camel@jason.corekin>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Jason Corekin <jason@corekin.no-ip.com>
Cc: Alsa User's <alsa-user@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

This is most likely (AFAIK) because redhat ships their kernel with NPTL
(Native POSIX Thread Library).

>From the release notes:

Red Hat Linux 9 includes the Native POSIX Thread Library (NPTL), a new
implementation of POSIX threads for Linux. This library provides
performance improvements and increased scalability for i686 or better
processors.

This thread library is designed to be binary compatible with the old
LinuxThreads implementation; however, applications that rely on the
places where the LinuxThreads implementation deviates from the POSIX
standard will need to be fixed. Notable differences include:

- Signal handling has changed from per-thread signal handling to POSIX
process signal handling.

- getpid() returns the same value in all threads.

- Thread handlers registered with pthread_atfork are not run if vfork()
is used - no manager thread

--------------------------

I could be wrong but this is where I think the problem is...


On Sun, 2003-03-30 at 16:19, Jason Corekin wrote:
> 	Good news I have Alsa 0.9.2 working on RedHat 9.0 working with kernel
> version 2.4.20.  The catch is that I had to replace the RedHat kernel
> with the stock kernel from www.kernel.org.  So the problem has to be in
> the changes that RedHat made to their kernel.  I have to give credit to
> Kmberry and Lance A. Brown, for pointing out that RedHat plays around
> with the kernel before releasing it  
> 	The only thing that I have not yet tried to do is to rework the
> symlinks to make sure that the Alsa code knows where to find the right
> kernel dependencies.  Since I do not know if there is any thing that I
> am now missing from not running on the RedHat kernel or not it would be
> nice to at least have some modules compatible with their kernel, but I'm
> not too worried about it.
> 	I hope this helps.
> 
> Jason Corekin 
> 
> 
> 
> On Sat, 2003-03-29 at 14:23, Jason Corekin wrote:
> > I work for HP and I just downloaded the new RH 9.0 iso's from our 
> > internal source yesterday.  After upgrading from RH 8.0 and the 2.4.18 
> > kernel I tried to update my Alsa drivers to work with the new 2.4.20 
> > kernel and found that althought the Alsa 0.9.2 drivers had compiled and 
> > installed without trouble the would not load.  Instead I am getting the 
> > error unresolved symbol schedule_work.
> > 
> > Now I know that there have been numerous similar complaints on the user 
> > mailing list, but since nobody seems to be privinding and answer and 
> > since I saw no mention of this error on the development list I thought 
> > that I would send out this mail to both lists and see if I could get a 
> > little bit more of a response.
> > 
> > I have a Yamahaa Waveforce 192XG, a 1.2Ghz Duron, 128MB of ram, and a 
> > ECS K7S5A motherboard.  But since this appears to be a layer other then 
> > the hardware driver layer and has been reported with to be affecting 
> > numerous cards, I really don't think that my hardware config will be of 
> > much importance.
> > 
> > Jason Corekin
> > 
> > 
> > 
> > -------------------------------------------------------
> > This SF.net email is sponsored by:
> > The Definitive IT and Networking Event. Be There!
> > NetWorld+Interop Las Vegas 2003 -- Register today!
> > http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> > _______________________________________________
> > Alsa-devel mailing list
> > Alsa-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Edward Muller

Interlix - President

Web Hosting - PC Service & Support
Custom Programming - Network Service & Support

Phone: 417-862-0573
 Cell: 417-844-2435
  Fax: 417-862-0572

http://www.interlix.com



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
