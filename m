From: Weijia Yang <gte733z@prism.gatech.edu>
Subject: CS46xx bass issues
Date: Thu, 17 Oct 2002 16:09:37 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DAF1901.9020008@prism.gatech.edu>
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I have been fooling around with the bass issues w/ the cs46xx CVS on 
turtle beach for a while now, with not much luck.  I was wondering if 
anybody who uses this card with the CVS who has had success could post 
their config files. Here is my config--probably a lot of uneeded stuff, 
but I have been fiddling around with it a lot.


# ALSA portion
alias char-major-116 snd
# OSS/Free portion
alias char-major-14 soundcore

##  ALSA portion
alias snd-card-0 snd-cs46xx
options snd-cs46xx snd_external_amp snd_mmap_valid snd-thinkpad
#alias snd-card-1 snd-cs46xx
##  OSS/Free portion
alias sound-slot-0 snd-card-0
#alias sound-slot-1 snd-card-1
##

# OSS/Free portion - card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss
##  OSS/Free portion - card #2
## alias sound-service-1-0 snd-mixer-oss
## alias sound-service-1-3 snd-pcm-oss
## alias sound-service-1-12 snd-pcm-oss

alias /dev/mixer snd-mixer-oss
alias /dev/dsp snd-pcm-oss
alias /dev/midi snd-seq-oss
-- 
Weijia Yang
School of Electrical and Computer Engineering
Georgia Institute of Technology
Atlanta, GA



-------------------------------------------------------
This sf.net email is sponsored by: viaVerio will pay you up to
$1,000 for every account that you consolidate with us.
http://ad.doubleclick.net/clk;4749864;7604308;v?
http://www.viaverio.com/consolidator/osdn.cfm
