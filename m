From: Jason Corekin <jason@corekin.no-ip.com>
Subject: Redhat 9.0 also has the snd.o unresolved symbol schedule_work issue
Date: Sat, 29 Mar 2003 14:23:56 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E861CFC.9040908@corekin.no-ip.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I work for HP and I just downloaded the new RH 9.0 iso's from our 
internal source yesterday.  After upgrading from RH 8.0 and the 2.4.18 
kernel I tried to update my Alsa drivers to work with the new 2.4.20 
kernel and found that althought the Alsa 0.9.2 drivers had compiled and 
installed without trouble the would not load.  Instead I am getting the 
error unresolved symbol schedule_work.

Now I know that there have been numerous similar complaints on the user 
mailing list, but since nobody seems to be privinding and answer and 
since I saw no mention of this error on the development list I thought 
that I would send out this mail to both lists and see if I could get a 
little bit more of a response.

I have a Yamahaa Waveforce 192XG, a 1.2Ghz Duron, 128MB of ram, and a 
ECS K7S5A motherboard.  But since this appears to be a layer other then 
the hardware driver layer and has been reported with to be affecting 
numerous cards, I really don't think that my hardware config will be of 
much importance.

Jason Corekin



-------------------------------------------------------
This SF.net email is sponsored by:
The Definitive IT and Networking Event. Be There!
NetWorld+Interop Las Vegas 2003 -- Register today!
http://ads.sourceforge.net/cgi-bin/redirect.pl?keyn0001en
