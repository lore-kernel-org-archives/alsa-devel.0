From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.12-rc5-mm1
Date: Fri, 27 May 2005 12:29:01 +0200
Message-ID: <200505271229.01699.rjw@sisk.pl>
References: <20050525134933.5c22234a.akpm@osdl.org> <200505261554.54807.rjw@sisk.pl> <20050526134532.1580defc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050526134532.1580defc.akpm@osdl.org>
Content-Disposition: inline
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
Cc: jamagallon@able.es, tomlins@cam.org, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thursday, 26 of May 2005 22:45, Andrew Morton wrote:
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> >
> > n Thursday, 26 of May 2005 09:58, Andrew Morton wrote:
> >  > "J.A. Magallon" <jamagallon@able.es> wrote:
> >  > >
> >  > > 
> >  > > On 05.26, Andrew Morton wrote:
> >  > > > 
> >  > > > (Added alsa-devel to cc)
> >  > > > 
> >  > > > Ed Tomlinson <tomlins@cam.org> wrote:
> >  > > > > 
> >  > > > > Got the following when I tried to use sound.  Anyone else see problems in alsa land?
> >  > > > > 
> >  > > 
> >  > > Me too. As beep-media-player ends playing a mp3 track, oops !
> >  > 
> >  > hm, OK, you're also on x86_64.  What sound card and driver?
> > 
> >  I've got the following on a dual-Opteron box with Tyan Thunder K8W (snd_intel8x0):
> 
> OK, thanks.  I guess we can set this problem aside for now, as this bug
> isn't present in 2.6.12-rc5 (correct?).

Yup.

> I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> possible that it lies elsewhere.

Well, yes.  Apparently, it goes away if you revert the following patch:

avoiding-mmap-fragmentation-fix-2.patch

Greets,
Rafael


-- 
- Would you tell me, please, which way I ought to go from here?
- That depends a good deal on where you want to get to.
		-- Lewis Carroll "Alice's Adventures in Wonderland"


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
