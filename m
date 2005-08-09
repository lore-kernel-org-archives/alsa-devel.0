From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: [linux-audio-dev] Re: any update on the
	pcmcia bug blocking Audigy2 notebook sound card driver development
Date: Tue, 09 Aug 2005 02:54:49 -0400
Message-ID: <1123570490.26998.1.camel@mindpipe>
References: <1ed860e3050807084449b0daac@mail.gmail.com>
	 <20050807104332.320aec48.akpm@osdl.org>
	 <1123519224.16205.5.camel@cmn37.stanford.edu>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1123519224.16205.5.camel@cmn37.stanford.edu>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Fernando Lopez-Lezcano <nando@ccrma.Stanford.EDU>
Cc: The Linux Audio Developers' Mailing List <linux-audio-dev@music.columbia.edu>, Raymond Lai <raymond.kk.lai@gmail.com>, linux-pcmcia@lists.infradead.org, alsa-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, James Courtier-Dutton <James@superbug.co.uk>
List-Id: alsa-devel@alsa-project.org

[added James to cc:]

On Mon, 2005-08-08 at 09:40 -0700, Fernando Lopez-Lezcano wrote:
> On Sun, 2005-08-07 at 10:43, Andrew Morton wrote:
> > Raymond Lai <raymond.kk.lai@gmail.com> wrote:
> > > Hi all,
> > > 
> > > I remember there's a kernel pcmcia bug preventing the development for 
> > > the Audigy2 pcmcia notebook sound card driver. 
> > > 
> > > See http://www.alsa-project.org/alsa-doc/index.php?vendor=vendor-Creative_Labs#matrix
> > > 
> > > Is there any new updates on the situation? Has the bug been fixed? or
> > > anyone working on it?
> >
> > Is it related to http://bugzilla.kernel.org/show_bug.cgi?id=4788 ?
> 
> I think not, the card in question is the Creative Audigy 2 ZS PCMCIA
> card. I have one I can't use yet :-( The kernel locks hard when ALSA
> tries to load the driver. 

Maybe we should have the emu10k1 driver not claim the device until this
is fixed.  It's better than locking the machine (this behavior has been
confirmed by several other users).

Lee



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
