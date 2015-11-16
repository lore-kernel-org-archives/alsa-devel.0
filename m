From: ROUGE ETIENNE <etiennerouge@yahoo.com>
Subject: M-audio 410 : complex procedure to get a sound
Date: Mon, 16 Nov 2015 09:55:01 +0100
Message-ID: <564999E5.30204@yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from nm45-vm7.bullet.mail.bf1.yahoo.com
 (nm45-vm7.bullet.mail.bf1.yahoo.com [216.109.115.78])
 by alsa0.perex.cz (Postfix) with ESMTP id 27DE2261615
 for <alsa-devel@alsa-project.org>; Mon, 16 Nov 2015 09:55:04 +0100 (CET)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello !

I've just bought a M-audio firewire 410 and I'm very thankfull to 
takashi's work that allows us to use the device almost like an USB one !

I can have sound and have access to the routing controls. However 2 bugs 
makes it a bit tedious :

NOTE : I use an up to date freshly installed ubuntustudio 15.10. The 
only modifications I made was 1) deleting pulse 2) select the soundcard 
as default in asoundrc

1) I do not have sound out of the box, but I can manage to have sound by 
starting ffado-mixer then force restart alsa. After that everything 
works fine.... but I gotta do it at every restart which isn't nice

2) ffado-mixer suffers several bugs :
- if I close the window I can't restart it again unless I kill 
ffado-dbus-server (it says : "another instance of ffado-mixer is already 
running).
-  I got few errors on startup "invalid samplerate for input"... don't 
know it it has any impact
- when I tweak too much ffado-mixer (AFAIK, it's random, but happens 
within few minuts) the mouse shows a 'hand closed' cursor and I can't 
click anything. The system remains fully functionnal, but I can't close 
anything nor click... If I start an emergency terminal I can kill 
whatever I want, but the problem remains.

I'll try with a fedora this evening to see if it's not related with 
ubuntustudio, but I'd be glad to have some help with those 2 issues 
(especially the stalling ffado-mixer)

thanks !

Etienne
