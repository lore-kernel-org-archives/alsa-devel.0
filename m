From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: [Jackit-devel] [Alsa-devel] alsaseq reorders my events
Date: Thu, 1 Mar 2007 16:51:48 -0000 (WET)
Message-ID: <18115.194.65.103.1.1172767908.squirrel@www.rncbc.org>
References: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <jackit-devel-bounces@lists.sourceforge.net>
In-Reply-To: <70a871c80703010535p512ebabfke3c57d441a7fe2fb@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=jackit-devel>
List-Post: <mailto:jackit-devel@lists.sourceforge.net>
List-Help: <mailto:jackit-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/jackit-devel>,
	<mailto:jackit-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: jackit-devel-bounces@lists.sourceforge.net
Errors-To: jackit-devel-bounces@lists.sourceforge.net
To: Dmitry Baikov <dsbaikov@gmail.com>
Cc: Jack Dev List <jackit-devel@lists.sourceforge.net>, alsa-devel@lists.sourceforge.net, linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org


On Thu, March 1, 2007 13:35, Dmitry Baikov wrote:
> Hi!
>
>
> I nearly finished alsaseq driver for jackmidi, but have a problem.
> Alsaseq reorders events in fast sequences, so note-on/note-off pairs got
> mixed.
>
> The algorithm of sending is simple:
>
>
> snd_seq_ev_schedule_real(&alsa_event, output_que, 1, &timestamp);
> frame_time = jack_frame_time(self->jack); frame_offset = event.time -
> frame_time;
>
> offset = ((long long)frame_offset) * 1000000000 / rate; timestamp.tv_sec =
> (long) (offset / 1000000000);
> timestamp.tv_nsec = (long) (offset % 1000000000);
> snd_seq_event_output(self->seq, &alsa_event);
>
>

Is the snd_seq_ev_schedule_real correct where it is? Or should you call
_after_ you set the intended timestamp, like this:


  frame_time = jack_frame_time(self->jack);
  frame_offset = event.time - frame_time;

  offset = ((long long)frame_offset) * 1000000000 / rate;
  timestamp.tv_sec = (long) (offset / 1000000000);
  timestamp.tv_nsec = (long) (offset % 1000000000);

  snd_seq_ev_schedule_real(&alsa_event, output_que, 1, &timestamp);

  snd_seq_event_output(self->seq, &alsa_event);


Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
