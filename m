From: Ivan Middleton <ivan_middleton@yahoo.com>
Subject: Re: problems with external MIDI port
Date: Thu, 19 Sep 2002 09:09:26 -0700 (PDT)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020919160926.25474.qmail@web13404.mail.yahoo.com>
Reply-To: ivan_middleton@yahoo.com
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
List-Archive: <http://sourceforge.net/mailarchives/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Just a follow-up to my previous email:  I now think that the problem
I'm experiencing may be the fault of timidity, or is at least related
to something that timidity is doing.  I set up a bunch of copies of
vkeybd (virtual keyboard), each connected to a copy of aseqview, and
then had a copy of aseqview listening to the external MIDI port, and
this never caused any problems.  So it doesn't seem to be the sheer
number of sequencer clients that's causing the problem.  Perhaps the
problem has something to do with the fact that timidity (when running
as an ALSA sequencer client) sets up multiple sequencer ports under a
single client.  (I recompiled timidity to set up 4 ports instead of 2,
so that running 'timidity -iA' sets it up listening on 128:0, 128:1,
128:2, 128:3 for example.)

Ivan


__________________________________________________
Do you Yahoo!?
New DSL Internet Access from SBC & Yahoo!
http://sbc.yahoo.com


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
