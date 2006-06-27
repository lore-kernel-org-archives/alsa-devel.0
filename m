From: Dave Jones <davej@redhat.com>
Subject: Re: list corruption on removal of snd_seq_dummy
Date: Tue, 27 Jun 2006 12:58:19 -0400
Message-ID: <20060627165819.GC1280@redhat.com>
References: <200606270808_MC3-1-C391-2F33@compuserve.com>
	<s5h8xniwz74.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <s5h8xniwz74.wl%tiwai@suse.de>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@lists.sourceforge.net>, linux-kernel <linux-kernel@vger.kernel.org>, Chuck Ebbert <76306.1226@compuserve.com>
List-Id: alsa-devel@alsa-project.org

On Tue, Jun 27, 2006 at 02:38:39PM +0200, Takashi Iwai wrote:
 > > > No, list_move() can't move the whole elements without loop.
 > > > 
 > > > A solution is
 > > > 
 > > >       list_add(B, A);
 > > >       list_del_init(A);
 > > > 
 > > > (although this introduces a bit more code :)
 > > 
 > > Shouldn't it be like this?
 > > 
 > >         ports_list_first = client->ports_list_head.next;
 > >         list_del_init(client->ports_list_head);
 > >         list_splice(ports_list_first, &deleted_list);
 > 
 > This requires INIT_LIST_HEAD(&deleted_list) first, so obviously
 > a longer code :)

This is hardly a speed/size critical function. I'd go for readability
over cute hacks any day.

		Dave

-- 
http://www.codemonkey.org.uk

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
