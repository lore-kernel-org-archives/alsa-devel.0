From: David Olofson <david@olofson.net>
Subject: Sequencer Note events...?
Date: Thu, 30 Jan 2003 13:14:13 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301301314.13290.david@olofson.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
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


I've noticed that there is a Note event type (the one with duration=20
and Off velocity), and means for sending it.

Does this mean I should also expect to receive such events? I've never=20
seen an example program handle this event, so I initially assumed=20
that it's actually a macro event that will be turned into separate=20
Note On and Note Off events by the sequencer.

What's the deal?


//David Olofson - Programmer, Composer, Open Source Advocate

=2E- The Return of Audiality! --------------------------------.
| Free/Open Source Audio Engine for use in Games or Studio. |
| RT and off-line synth. Scripting. Sample accurate timing. |
`---------------------------> http://olofson.net/audiality -'
   --- http://olofson.net --- http://www.reologica.se ---



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
