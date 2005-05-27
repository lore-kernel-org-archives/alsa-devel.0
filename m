From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
Subject: RE: 2.6.12-rc5-mm1
Date: Fri, 27 May 2005 10:38:52 -0700
Message-ID: <200505271738.j4RHcqg04138@unix-os.sc.intel.com>
References: <200505271229.01699.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200505271229.01699.rjw@sisk.pl>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "'Rafael J. Wysocki'" <rjw@sisk.pl>, Andrew Morton <akpm@osdl.org>
Cc: jamagallon@able.es, tomlins@cam.org, linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Rafael J. Wysocki wrote on Friday, May 27, 2005 3:29 AM
> > I assume the problem is due to one of the ASLA patches in rc5-mm1, but it's
> > possible that it lies elsewhere.
> 
> Well, yes.  Apparently, it goes away if you revert the following patch:
> 
> avoiding-mmap-fragmentation-fix-2.patch


avoiding-mmap-fragmentation-fix-2.patch has a major clash using
vm_private_data where alsa is also using.  I just posted a patch,
please try that out.  Thanks.

http://marc.theaimsgroup.com/?l=linux-mm&m=111721191501940&w=2

- Ken



-------------------------------------------------------
This SF.Net email is sponsored by Yahoo.
Introducing Yahoo! Search Developer Network - Create apps using Yahoo!
Search APIs Find out how you can build Yahoo! directly into your own
Applications - visit http://developer.yahoo.net/?fr=offad-ysdn-ostg-q22005
