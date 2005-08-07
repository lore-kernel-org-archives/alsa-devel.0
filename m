From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: any update on the pcmcia bug blocking Audigy2
	notebook sound card driver development
Date: Sun, 07 Aug 2005 14:41:35 -0400
Message-ID: <1123440095.12766.3.camel@mindpipe>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	 <20050807104332.320aec48.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050807104332.320aec48.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Andrew Morton <akpm@osdl.org>
Cc: Raymond Lai <raymond.kk.lai@gmail.com>, linux-kernel@vger.kernel.org, linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net, linux-audio-dev@music.columbia.edu, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

On Sun, 2005-08-07 at 10:43 -0700, Andrew Morton wrote:
> Raymond Lai <raymond.kk.lai@gmail.com> wrote:
> >
> > Hi all,
> > 
> > I remember there's a kernel pcmcia bug preventing the development for 
> > the Audigy2 pcmcia notebook sound card driver. 
> > 
> > See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> > 
> > Is there any new updates on the situation? Has the bug been fixed? or
> > anyone working on it?
> > 
> 
> Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?

No, that was a known issue that is resolved in 2.6.13-rc*.  This is the
bug he's referring to:

http://lkml.org/lkml/2005/7/11/265

Looks like James never followed up, probably due to OLS.

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
