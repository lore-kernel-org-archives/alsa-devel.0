From: "Mr. Mailing List" <mailinglistaddie@yahoo.com>
Subject: despite using ali5451 driver, things say no alsa card detected
Date: Sun, 31 Aug 2003 08:37:56 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030831153756.34929.qmail@web20710.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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

I have sound working, but i can't use alsactl
store/restore nor do certain applications see alsa
card.
(i have sbaudigy on another machine, same kernel,
test4, and all this works)
here are the entries i put in modprobe.conf, (Also it
doesn't seem to load sound automatically)
how do i get alsactl and stuff to recognize that there
IS a card?  until i get this done, i can't use it to
restore sound settings on boot, nor can applications
like xmame use alsa driver(whereas they can on my
sbaudigy)

#ALSA portion
alias char-major-116 snd
alias snd-card-0 snd-ali5451
                                                      
                         
#OSS/Free portion
alias char-major-14 soundcore
alias sound-slot-0 snd-card-0
                                                      
                         
#card #1
alias sound-service-0-0 snd-mixer-oss
alias sound-service-0-1 snd-seq-oss
alias sound-service-0-3 snd-pcm-oss
alias sound-service-0-8 snd-seq-oss
alias sound-service-0-12 snd-pcm-oss




__________________________________
Do you Yahoo!?
Yahoo! SiteBuilder - Free, easy-to-use web site design software
http://sitebuilder.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
