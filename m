From: "Lance A. Brown" <lance@bearcircle.net>
Subject: Re: alsa cvs, redhat9, kernel 2-4-20-8
Date: 09 Apr 2003 00:58:50 -0400
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <1049864330.10782.14.camel@circle.homeip.net>
References: <se8e13a5.075@mail.teklinks.com>
	 <20030405120028.6812ba7e.matthias@rpmforge.net>
	 <s5hznn2r4n9.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <s5hznn2r4n9.wl@alsa2.suse.de>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: Takashi Iwai <tiwai@suse.de>
Cc: Matthias Saou <matthias@rpmforge.net>, Jeremy Sanders <jsanders@teklinks.com>, jason@corekin.no-ip.com, alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net, matthias.saou@est.une.marmotte.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2003-04-07 at 06:19, Takashi Iwai wrote:
> At Sat, 5 Apr 2003 12:00:28 +0200,
> Matthias Saou wrote:
> > 
> > "Jeremy Sanders" <jsanders@teklinks.com> wrote :
> > 
> > > Maybe matthias.saou@est.une.marmotte.net is the one to ask. He's the one
> > > who built the freshrpm package that works with the redhat 9 kernel.
> > > Maybe he can shed some light on what he had to do.
> > > 
> > > Matthias,
> > > 
> > > Do you have any ideas about this?
> > 
> > Yes I have :-)
> > I didn't think of it myself though, someone had suggested me this solution
> > a while back for the latest Rawhide kernels. Take a look at my spec file if
> > you like: http://freshrpms.net/packages/builds/index.html?build=alsa-driver
> > 
> > The part that "fixes" the schedule_work problem is:
> > 
> > # Temporary Rawhide kernel workaround - Disable ALSA workqueue wrapper
> > touch include/linux/workqueue.h

This trick worked for me like a treat!

--[Lance]

-- 
  Carolina Spirit Quest:  http://www.carolinaspiritquest.org/
  Celebrate The Circle: http://www.angelfire.com/nc/celebratethecircle/
  My LiveJournal: http://www.livejournal.com/users/labrown/



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
