From: Paul Davis <paul@linuxaudiosystems.com>
Subject: Re: ALSA CVS and JACK?
Date: Tue, 25 Feb 2003 14:00:23 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E18nkHF-0001xJ-00@sc8-sf-list1.sourceforge.net>
References: <20030225190628.2b0033bf.mdeboer@iua.upf.es>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: Your message of "Tue, 25 Feb 2003 19:06:28 +0100."
             <20030225190628.2b0033bf.mdeboer@iua.upf.es>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Maarten de Boer <mdeboer@iua.upf.es>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>> can jaroslav or takashi fill me in on the current state of ALSA CVS
>> with respect to JACK? there have been many, many reports of JACK
>> crashing machines when run with recent ALSA CVS in real-time mode, and
>> mentions here on alsa-devel of configure-time JACK detection that
>> causes certain code to be commented out, or something like that.
>
>I don't find those mentions, and I don't find the code either. 

you're right. i misread the message i was thinking of. but i am sure
jaroslav said something about not understanding why a certain piece of
code was a problem with/without JACK.

>I also have experienced crashed (well, freezes) with jack in RT mode,
>but I don't think it has to do anything with alsa.

all the evidence we have on jackit-dev points to this. people can
switch between ALSA versions, and it crashes with a newer copy and not
with an earlier one. there are some suggestions that its a kernel+ALSA
problem. the fact that it only happens in RT mode suggests some
interaction of SCHED_FIFO scheduling and kernel locking or something
like that.

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
