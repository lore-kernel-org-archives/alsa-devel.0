From: David Olofson <david@olofson.net>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Sun, 15 Jun 2003 20:52:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306152052.05435.david@olofson.net>
References: <3EEC9BC6.5090603@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3EEC9BC6.5090603@folkwang-hochschule.de>
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

On Sunday 15 June 2003 18.16, Joern Nettingsmeier wrote:
[...]
>          /*{SND_SEQ_EVENT_NONREGPARAM, extra_decode_nrpn},*/
>          /*{SND_SEQ_EVENT_REGPARAM, extra_decode_rpn},*/
> };
>
> which makes me think it might not yet be implemented....

I'm using NRPNs to control the mixer in the current development=20
version of Audiality, and they appear to be working just fine, and=20
just like one would expect.


> any hints or fine manuals around ?

Do you need one? :-)

What you get is plain <control, value> tuples, and that's all there is=20
to it. (Well, it's all I *want* anyway, as I don't want to do stuff=20
that's outside the MIDI spec...)

Here's some code, which isn't heavily tested, but does seem to do the=20
job:

static void alsaseq_read(struct A_device *dev, unsigned frames)
{
        int more =3D 1;
        snd_seq_event_t *ev;
        ALSASEQ_data *d =3D (ALSASEQ_data *) dev->driver_data;
        dev->read_ms->time =3D aev_timer;
        while(more)
        {
                more =3D snd_seq_event_input(d->seq_handle, &ev);
                if(more < 0)
                        break;

                switch (ev->type)
                {
                  case SND_SEQ_EVENT_CONTROLLER:
                        dev->read_ms->control(
                                        ev->data.control.channel,
                                        ev->data.control.param,
                                        ev->data.control.value);
                        break;
                  case SND_SEQ_EVENT_NONREGPARAM:
                        dev->read_ms->nrpn(ev->data.control.channel,
                                        ev->data.control.param,
                                        ev->data.control.value);
                        break;

=09=09...

                  case SND_SEQ_EVENT_PITCHBEND:
                        dev->read_ms->bend(ev->data.control.channel,
                                        ev->data.control.value);
                        break;
                }
                snd_seq_free_event(ev);
        }
}


//David Olofson - Programmer, Composer, Open Source Advocate

=2E- The Return of Audiality! --------------------------------.
| Free/Open Source Audio Engine for use in Games or Studio. |
| RT and off-line synth. Scripting. Sample accurate timing. |
`-----------------------------------> http://audiality.org -'
   --- http://olofson.net --- http://www.reologica.se ---



-------------------------------------------------------
This SF.NET email is sponsored by: eBay
Great deals on office technology -- on eBay now! Click here:
http://adfarm.mediaplex.com/ad/ck/711-11697-6916-5
