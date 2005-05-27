From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: RE: 2.6.12-rc5-mm1 alsa oops
Date: Fri, 27 May 2005 09:42:38 -0700
Message-ID: <200505271642.j4RGgbg03476@unix-os.sc.intel.com>
References: <20050526142444.01363443.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20050526142444.01363443.akpm@osdl.org>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: 'Andrew Morton' <akpm@osdl.org>, Wolfgang Wander <wwc@rentec.com>
Cc: rlrevell@joe-job.com, petkov@uni-muenster.de, pharon@gmail.com, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Andrew Morton wrote on Thursday, May 26, 2005 2:25 PM
> > >>
> > >>this has to do with alsa indirectly. snd_pcm_mmap_data_close() accesses some 
> > >>vm_area_struct->vm_private_data and apparently there have been some 
> > >>optimizations to mmap code to avoid fragmentation of vma's so i think there's 
> > >>the problem. However, we'll need the smarter ones here :))
> > > 
> > > 
> > > Any idea which patches to back out?
> > 
> > 
> > avoiding-mmap-fragmentation-fix-2.patch
> > 
> > seems to do the trick. Ken will likely have a fix-3 shortly ;-)
> > 
> 
> Yup.  This appears to be not-an-alsa-bug.  Thanks.


I'm the guilty one here.  avoiding-mmap-fragmentation-fix-2.patch has
a major clash using vm_private_data where alsa is also using.  I just
posted a patch, please try that out.  Thanks.

http://marc.theaimsgroup.com/?l=linux-mm&m=111721191501940&w=2

- Ken



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
