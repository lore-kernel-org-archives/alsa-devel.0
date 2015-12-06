From: Takashi Sakamoto <o-takashi@sakamocchi.jp>
Subject: Re: M-audio 410 : complex procedure to get a sound
Date: Sun, 6 Dec 2015 22:46:20 +0900
Message-ID: <56643C2C.9000503@sakamocchi.jp>
References: <564999E5.30204@yahoo.com> <56547212.3010507@sakamocchi.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp303.phy.lolipop.jp (smtp303.phy.lolipop.jp [210.157.22.87])
 by alsa0.perex.cz (Postfix) with ESMTP id A1C39265379
 for <alsa-devel@alsa-project.org>; Sun,  6 Dec 2015 14:46:25 +0100 (CET)
In-Reply-To: <56547212.3010507@sakamocchi.jp>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: ROUGE ETIENNE <etiennerouge@yahoo.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi,

Sorry to be late but I caught a cold last weekend and some works were
postpone.

On Nov 24 2015 23:20, Takashi Sakamoto wrote:
>> 2) ffado-mixer suffers several bugs :
>> - if I close the window I can't restart it again unless I kill
>> ffado-dbus-server (it says : "another instance of ffado-mixer is already
>> running).

I can reproduce this bug. A workaround is to run ffado-dbus-server in
advance, then launch ffado-mixer. I don't know the cause of this bug
because it's long ago I worked for ffado tools.

>> -  I got few errors on startup "inval
id samplerate for input"... don't
>> know it it has any impact

I think the message is like:
Error (avc_avdevice.cpp)[ 300] supportsSamplingFrequency: sample rate
not supported by input plug

I don't know the cause.

>> - when I tweak too much ffado-mixer (AFAIK, it's random, but happens
>> within few minuts) the mouse shows a 'hand closed' cursor and I can't
>> click anything. The system remains fully functionnal, but I can't close
>> anything nor click... If I start an emergency terminal I can kill
>> whatever I want, but the problem remains.

I think it's a bug of Qt4 tools on recent desktop environment based on
Gtk. I can reproduce it with qsynth and kmidimon. I don't know the cause...

>> I'll try with a fedora this evening to see if it's not related with
>> ubuntustudio, but I'd be glad to have some help with those 2 issues
>> (especially the stalling ffado-mixer)

The ffado-mixer utilizes ffado-dbus-server to communicate to actual
devices. But the program is not better shape as a system server or IEEE
1394 application. You must stop a process of the server when you close
ffado-mixer or you re-connect your model to system.


Thanks

Takashi Sakamoto
