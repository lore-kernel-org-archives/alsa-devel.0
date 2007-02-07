From: Julien Puydt <jpuydt@free.fr>
Subject: Question about getting the name of devices
Date: Wed, 07 Feb 2007 13:22:24 +0100
Message-ID: <45C9C480.4050402@free.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi,

I'm trying to patch the alsasrc&alsasink gstreamer plugins to be able to 
show nice names in user interfaces.

Given a card number, using snd_card_get_name gets me what I want easily. 
Unfortunately, that's not what I have available : I just have a 
snd_pcm_t*, opened on a char* which may look like "hw:1,0".

I know that I can snd_ctl_open a snd_ctl_t* with "hw:1", then get a 
snd_ctl_card_info_t*, on which I can call snd_ctl_card_info_get_card, to 
finally be able to call snd_card_get_name (sic).

The problem with this approach (well, apart from the fact that it is 
overly complex), is that snd_ctl_open fails if something like "hw:1,0" 
is given to it.

Is there a sane and simple way to obtain the name of a card from the 
data I have ?

JP

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
