From: Ryan Pavlik <rpav@mephle.com>
Subject: Simple alsa sequencer question
Date: Sat, 25 Oct 2003 02:41:06 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031025024106.3aad73cc.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

Minor question... I probably just overlooked something...
but when I subscribe to a port, and I've done this:

        :
    snd_seq_port_subscribe_set_queue(subs, 1);
    snd_seq_port_subscribe_set_time_update(subs, 1);
    snd_seq_port_subscribe_set_time_real(subs, 1);
        :

Shouldn't I get numbers in ev->time.time.tv_*?  I'm just getting
zeros... what did I miss? ;)

-- 
Ryan Pavlik <rpav@mephle.com>

"I was promised claws and an impossible biology!" - 8BT


-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
