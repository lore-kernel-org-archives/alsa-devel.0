From: "John S. Denker" <jsd@monmouth.com>
Subject: hard crash when snd-ice1712 loads
Date: Thu, 05 Dec 2002 06:52:45 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3DEF3E0D.3040704@monmouth.com>
References: <3DEF2ED7.7000808@monmouth.com> <3DEF3911.4060206@monmouth.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3DEF2ED7.7000808@monmouth.com>
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

     ==== This is a slightly-updated clone of item
     #648063 on the sourceforge bug/patch reporting
     system.  I'm moving it to here (the alsa-devel
     mailing list) at the request of Jaroslav. ====

hard crash when snd-ice1712 loads

Using snd-ice1712 under rc6 (but not rc3) I observe:

    init.d/alsasound start
Starting sound driver: snd-ice1712 done

... and that's all she wrote.

The kernel crashes, hard.  It won't respond to
ctrl-alt-delete.  The num-lock light won't respond to
num-lock key.  (These symptoms are often associated with a
tight loop with the interrupts disabled.)

It is interesting to note that this card works fine under
rc3.  Unfortunately there has been a drastic rearrangement
of the code, so it won't be a simple matter of using diff
to highlight the differences.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
