From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: Re: pcm_jack and jack chicken-and-egg situation
Date: Wed, 5 Mar 2003 10:11:57 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030305101157.3373dbfc.mdeboer@iua.upf.es>
References: <1046822550.8620.193.camel@insanity.tek.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1046822550.8620.193.camel@insanity.tek.net>
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

Bob Ham <rah@bash.sh> wrote:
> The new pcm_jack thing presents a bit of a chicken and egg problem; I
> just compiled alsa-lib twice because jack depends on alsa-lib and if you
> configure alsa-lib with jack support, it depends on jack.  Would it be
> possible for pcm_jack to be distributed seperately?

Hi Bob,

That's indeed a problem I did not realize... And there is an another,
related problem, which is that with binary distributions, you have 
to either distribute to versions, one linked against jack and one not
linked against jack.

The ALSA plugin's are all compiled into the library. It would indeed be
nice if each plugin would be a seperate shared object. Maybe Jaroslav
has concrete objections against this? Anyway, it would represent quite
a bit of change to the code, which I suppose just before 0.9.0 final
is not the best moment.. 

Another solution would be not to link against jack, but use the dynamic
linker loader (dlopen, dlsym). This would require to link against libdl,
but I suppose that that is okay.

Maarten






-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
