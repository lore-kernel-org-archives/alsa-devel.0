From: Jason Corekin <jason@corekin.no-ip.com>
Subject: Re: Redhat 9.0 also has the snd.o unresolved symbol
	schedule_work issue
Date: 30 Mar 2003 14:19:48 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049062787.3017.22.camel@jason.corekin>
References: <3E861CFC.9040908@corekin.no-ip.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3E861CFC.9040908@corekin.no-ip.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Alsa User's <alsa-user@lists.sourceforge.net>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

	Good news I have Alsa 0.9.2 working on RedHat 9.0 working with kernel
version 2.4.20.  The catch is that I had to replace the RedHat kernel
with the stock kernel from www.kernel.org.  So the problem has to be in
the changes that RedHat made to their kernel.  I have to give credit to
Kmberry and Lance A. Brown, for pointing out that RedHat plays around
with the kernel before releasing it  
	The only thing that I have not yet tried to do is to rework the
symlinks to make sure that the Alsa code knows where to find the right
kernel dependencies.  Since I do not know if there is any thing that I
am now missing from not running on the RedHat kernel or not it would be
nice to at least have some modules compatible with their kernel, but I'm
not too worried about it.
	I hope this helps.

Jason Corekin 



On Sat, 2003-03-29 at 14:23, Jason Corekin wrote:
> I work for HP and I just downloaded the new RH 9.0 iso's from our 
> internal source yesterday.  After upgrading from RH 8.0 and the 2.4.18 
> kernel I tried to update my Alsa drivers to work with the new 2.4.20 
> kernel and found that althought the Alsa 0.9.2 drivers had compiled and 
> installed without trouble the would not load.  Instead I am getting the 
> error unresolved symbol schedule_work.
> 
> Now I know that there have been numerous similar complaints on the user 
> mailing list, but since nobody seems to be privinding and answer and 
> since I saw no mention of this error on the development list I thought 
> that I would send out this mail to both lists and see if I could get a 
> little bit more of a response.
> 
> I have a Yamahaa Waveforce 192XG, a 1.2Ghz Duron, 128MB of ram, and a 
> ECS K7S5A motherboard.  But since this appears to be a layer other then 
> the hardware driver layer and has been reported with to be affecting 
> numerous cards, I really don't think that my hardware config will be of 
> much importance.
> 
> Jason Corekin
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by:
> The Definitive IT and Networking Event. Be There!
> NetWorld+Interop Las Vegas 2003 -- Register today!
> http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel
-- 
Jason Corekin <jason@corekin.no-ip.com>



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
