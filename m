From: David Olofson <david@olofson.net>
Subject: Re: sequencer: handling non-registered parameter numbers....
Date: Mon, 16 Jun 2003 10:41:05 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200306161041.05077.david@olofson.net>
References: <Pine.LNX.4.44.0306161025340.11284-100000@pnote.perex-int.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <Pine.LNX.4.44.0306161025340.11284-100000@pnote.perex-int.cz>
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

On Monday 16 June 2003 10.29, Jaroslav Kysela wrote:
[...]
> The driver code and alsa-lib does not handle nonreg and reg
> parameters. They simply pass them like standard controllers, so the
> four event sequence is ok. I think that we may add this piece code
> to seq_midi_event.c.

This is weird... Wonder what's actually happening in there. :-)


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
