From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Simple alsa sequencer question
Date: Mon, 27 Oct 2003 13:14:56 +0100 (MET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0310271312410.29105-100000@studcom.urz.uni-halle.de>
References: <20031025024106.3aad73cc.rpav@mephle.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-reply-to: <20031025024106.3aad73cc.rpav@mephle.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ryan Pavlik <rpav@mephle.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ryan Pavlik wrote:
> but when I subscribe to a port, and I've done this:
>         :
>     snd_seq_port_subscribe_set_queue(subs, 1);
>     snd_seq_port_subscribe_set_time_update(subs, 1);
>     snd_seq_port_subscribe_set_time_real(subs, 1);
>         :
> Shouldn't I get numbers in ev->time.time.tv_*?  I'm just getting
> zeros... what did I miss? ;)

The second parameter of ..._set_queue is the id of the queue to get
the time from. Probably queue #1 doesn't exist, or isn't running when
the events get delivered.


HTH
Clemens




-------------------------------------------------------
This SF.net email is sponsored by: The SF.net Donation Program.
Do you like what SourceForge.net is doing for the Open
Source Community?  Make a contribution, and help us add new
features and functionality. Click here: http://sourceforge.net/donate/
