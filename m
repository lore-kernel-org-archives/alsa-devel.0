From: Lee Revell <rlrevell@joe-job.com>
Subject: serialmidi change breaks build on 2.6.10-rc2-mm2
Date: Tue, 23 Nov 2004 18:31:02 -0500
Message-ID: <1101252663.5207.7.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Rather than fixing anything this change actually broke compilation on my
kernel.  Is this change only in the latest rc or Linus' BK tree?

+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2, 6, 10)
+                       count = driver->write(tty, buf, count);
+#else
                        count = driver->write(tty, 0, buf, count);
+#endif
                        snd_rawmidi_transmit_ack(serial->substream_output, count);
                } else {
                        clear_bit(TTY_DO_WRITE_WAKEUP, &tty->flags);


-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
