From: Lee Revell <rlrevell@joe-job.com>
Subject: emu10k1 "swap front and rear"
Date: Fri, 26 Aug 2005 17:43:14 -0400
Message-ID: <1125092595.25011.39.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Several users have asked for a "swap front and rear" mixer control for
this device, as it's well known that the codec driving the rear channels
is of higher quality than the front (something like 10x better THD, I
don't have the link handy).  For example the kS driver has this, and
it's enabled by default.  I think the difference is audible.

Rather than doing it in the DSP like the kX driver, it occurred to me
that this could be done in alsa-lib.  Just reverse the definitions of
"front", "rear" (and surround*) in the .asoundrc.

Does the ALSA API support a control like this, that could be implemented
in the asound.conf but exposed to the mixer as a "Swap front and Rear"
toggle?

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
