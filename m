From: Bob Ham <node@users.sourceforge.net>
Subject: Re: timestamps on recorded events
Date: 12 Apr 2002 11:52:25 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1018608745.13866.2.camel@insanity>
References: <Pine.LNX.4.33.0204091221050.7128-100000@wotan.suse.de>
	<200204110944.AFK42109@msgdirector2.onetel.net.uk>
	<s5h8z7ule68.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8z7ule68.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: ALSA Development Mailing List <alsa-devel@lists.sourceforge.net>
Cc: Takashi Iwai <tiwai@suse.de>
List-Id: alsa-devel@alsa-project.org

On Thu, 2002-04-11 at 11:31, Takashi Iwai wrote:

> 	// enable time-stamp-update mode
> 	snd_seq_port_subscribe_set_time_update(subs, 1);
> 	// if you want to get real-time (not tick), call the
> 	// following, too
> 	// snd_seq_port_subscribe_set_time_real(subs, 1);

Does the value of the integer that's passed to either of these functions
make any difference, or is it just their non-zeroness?

Bob

-- 
Bob Ham: bob@ham.org  http://pkl.net/~node/

My music: http://mp3.com/obelisk_uk
GNU Hurd: http://hurd.gnu.org/
