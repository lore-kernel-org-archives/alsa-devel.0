From: Gerald Grabner <gerald.grabner@tugraz.at>
Subject: How to set ppq?
Date: Mon, 23 Dec 2002 14:19:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E070D6A.8010503@tugraz.at>
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

Hi,

I'm trying to set PPQ for the alsa sequencer queue but it doesn't
work. Here is the piece of code:

   snd_seq_queue_tempo_set_tempo (queue_tempo, tempo) ;
   snd_seq_queue_tempo_set_ppq   (queue_tempo, ppq  ) ;
   snd_seq_set_queue_tempo (seq_handle, queue_id, queue_tempo) ;

It works for tempo, but not for ppq. Does anybody know how I could
also set ppq?

Thanks a lot!
Gerald

BTW: It's on a SuSE 8.1 box that comes with alsa-0.9.0rc3,
cvs20020903.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
