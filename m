From: Pedro Lopez-Cabanillas <plcl@telefonica.net>
Subject: Re: General Guidelines?  (MIDI)
Date: Thu, 16 Jan 2003 22:27:35 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301162227.36021.plcl@telefonica.net>
References: <E18ZGLH-0005nh-00@sc8-sf-list2.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <E18ZGLH-0005nh-00@sc8-sf-list2.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Brian Victor <bhv1@psu.edu>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday 16 January 2003 21:08, Brian Victor wrote:
> I've removed all attachments to wxWindows, so anyone should be able to
> compile my test program.  So I don't have to keep sending snippits out
> of context, the code is here:
>
> http://www.personal.psu.edu/users/b/h/bhv1/nowx.cc      or
> http://www.personal.psu.edu/users/b/h/bhv1/nowx.cc.html (syntax colored)
> (g++ nowx.cc -o nowx -lasound)

In short: start the queue before sending events, add snd_seq_drain_output at 
end of SetTempo method.

I wrote some example programs in plain C while learning ALSA API (player, 
recorder, metronome, monitor...)
http://perso.wanadoo.es/plcl/alsautil.tar.bz2

More examples, for Kylix and FreePascal:
http://perso.wanadoo.es/plcl/

HTH

--- nowx.cc.old Thu Jan 16 22:11:17 2003
+++ nowx.cc     Thu Jan 16 22:08:59 2003
@@ -64,14 +64,14 @@
   wxMidiOutput outport(sequencer);
   wxMidiQueue queue(sequencer);
   int x;
-  for (x = 0; x < 400; ++x)
-  {
-    queue.NoteOn(outport, x, 127, x);
-  }
   cout << "Queue will start in five seconds" << endl;
   sleep(5);
   cout << "Starting queue" << endl;
   queue.StartQueue();
+  for (x = 0; x < 400; ++x)
+  {
+    queue.NoteOn(outport, x , 127, x);
+  }
   while (1) {
     sleep(1);
   }
@@ -181,6 +181,7 @@
   snd_seq_queue_tempo_set_ppq(tpo, 128);
   snd_seq_set_queue_tempo(m_drv.GetAlsaSeq(), m_queue, tpo);
   snd_seq_queue_tempo_free(tpo);
+  snd_seq_drain_output(m_drv.GetAlsaSeq());
 }

 void wxMidiQueue::StartQueue()



-------------------------------------------------------
This SF.NET email is sponsored by: Thawte.com
Understand how to protect your customers personal information by implementing
SSL on your Apache Web Server. Click here to get our FREE Thawte Apache 
Guide: http://ads.sourceforge.net/cgi-bin/redirect.pl?thaw0029en
