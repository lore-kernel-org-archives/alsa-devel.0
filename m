From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Merging alsa-kernel-1.0.7 into kernel 2.6.9
Date: Thu, 18 Nov 2004 23:50:59 -0500
Message-ID: <1100839859.11044.33.camel@krustophenia.net>
References: <DBFABB80F7FD3143A911F9E6CFD477B002A7F808@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B002A7F808@hqemmail02.nvidia.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Stephen Warren <SWarren@nvidia.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2004-11-18 at 20:41 -0800, Stephen Warren wrote:
> I'm working on a project where we don't use modules for the kernel at
> all - for various reasons such as target environment simplicity - very
> hard-coded boot scripts, no huge sysvinit based interactive 'desktop'
> system etc.
> 
> We need ALSA support, and specifically, alsa-driver 1.0.7 release fixes
> some problems for the target hardware we're using.
> 
> So, I'm attempting to merge the content of alsa-driver 1.0.7 into the
> kernel source tree, and to build ALSA support as non-modules.

If the range of hardware you need to support is cmall enough it might be
easier to start with the ALSA in your kernel tarball and forward port
any driver fixes you need.

HTH,

Lee 



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
