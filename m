From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH/RFC] emu10k1 multichannel PCM
Date: Wed, 17 Nov 2004 11:37:22 -0500
Message-ID: <1100709443.6930.12.camel@krustophenia.net>
References: <1100300857.19038.14.camel@krustophenia.net>
	 <1100405924.16103.23.camel@krustophenia.net>
	 <1100672577.5832.7.camel@krustophenia.net>  <s5his84si8l.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5his84si8l.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Wed, 2004-11-17 at 14:44 +0100, Takashi Iwai wrote:
> > Here is the latest version.  This fixes the send routing and mixer
> > controls.  Among other things there was a copy and paste bug in
> > emumixer.c.
> > 
> > I have tested this one with JACK and Hydrogen, it actually works better
> > at 64 frames than it did with separate capture/playback interrupts.
> > 
> > The patch is up to 1200 lines or so.  It should not get much longer.
> > There are still some bugs; this is not ready to commit yet but getting
> > close.

> We still need to discuss the mixer handling, but otherwise the
> implementation seems ok to me.
> 

OK.  I will try moving them to IFACE_PCM, while retaining compatibility
for the existing devices.

> The code looks alsmot fine.  Please keep the 8-letter tab stop for
> indentation, and be careful about the compatibility with the older gcc
> such as variable definition in the middle of the function.
> 

OK.

> I expect that debug prints will be eliminated in the final version,
> right?
> 

Correct, I will clean this up before posting the final patch.  I just
posted the full diff to get some feedback.

Lee




-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
