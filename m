From: Stephen Hassard <steve@hassard.net>
Subject: Audigy 2 support - update
Date: Thu, 22 May 2003 22:12:40 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030523051240.GA10831@www.angiotech.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
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

I haven't tried my Audigy 2 under Alsa for a while. I decided to pop it in my machine tonight and give it a try. I'm using a build from today's CVS.

The Audigy 2 doesn't seem to be listed on the alsa soundcard matrix. Maybe it'll get updated with my results ..

Anyhow, PCM support seems to work fine, tone controls work too. Mixing different PCM sources seems to work well too (playing mp3 from xmms while playing wolfenstein).

sfxload loads soundfonts into the synth, and plays well.

I've connected my midi keyboard to the keyboard port via an adapter, and I can route my midi keypressed to the Audigy 2 synth using my soundfont.

I haven't tried any digital out, but otherwise I haven't seen any problems.

later,
Steve


-------------------------------------------------------
This SF.net email is sponsored by: ObjectStore.
If flattening out C++ or Java code to make your application fit in a
relational database is painful, don't do it! Check out ObjectStore.
Now part of Progress Software. http://www.objectstore.net/sourceforge
