From: Chris Wright <chrisw@osdl.org>
Subject: Re: 2.6.12-rc5-mm1
Date: Thu, 26 May 2005 14:07:58 -0700
Message-ID: <20050526210758.GK23013@shell0.pdx.osdl.net>
References: <20050525134933.5c22234a.akpm@osdl.org> <1117093392l.17165l.0l@werewolf.able.es> <20050526005841.08a8aae0.akpm@osdl.org> <200505261554.54807.rjw@sisk.pl> <20050526134532.1580defc.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20050526134532.1580defc.akpm@osdl.org>
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
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, jamagallon@able.es, tomlins@cam.org, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

* Andrew Morton (akpm@osdl.org) wrote:
> I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> possible that it lies elsewhere.  It would be great if someone could fire
> up quilt and do a binary search...

I had started that, but then read a few accounts of backing out
avoiding-mmap-fragmentation-fix-2.patch fixing the problem.  Both that
patch and alsa are using vm_private_data.  Madness ensues.


-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
