From: Glenn Maynard <g_sf@zewt.org>
Subject: Re: ALSA API
Date: Sun, 4 Jan 2004 15:17:18 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040104201718.GB27227@zewt.org>
References: <Law10-F11548UXHnnC000008fa6@hotmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <Law10-F11548UXHnnC000008fa6@hotmail.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, Jan 04, 2004 at 09:19:16AM -0800, Alex Lau wrote:
> I try to run the minimal playback program from the tutorial found in the 
> alsa web site,
> 
> snd_pcm_t  *handle;
> char  *device = "hw:0,0";

Shouldn't the tutorial be using "default", if that's what programs that
don't care should be using?  (The arguments used in tutorials are what
most applications are going to use.)

-- 
Glenn Maynard


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
