From: Lee Revell <rlrevell@joe-job.com>
Subject: RE: Merging alsa-kernel-1.0.7 into kernel 2.6.9
Date: Fri, 19 Nov 2004 13:32:02 -0500
Message-ID: <1100889124.11973.11.camel@krustophenia.net>
References: <DBFABB80F7FD3143A911F9E6CFD477B002A7F813@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <DBFABB80F7FD3143A911F9E6CFD477B002A7F813@hqemmail02.nvidia.com>
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

On Fri, 2004-11-19 at 08:25 -0800, Stephen Warren wrote:
> Unfortunately, this probably isn't an option for us. Whilst we're
> targetting an embedded style userspace, we don't control the hardware,
> and it can end up being basically any arbitrary PC right now. Thus, we
> need good support for everything ALSA can give us!
> 

OK that was just a suggestion for a quick fix.  It really should work
the way you said.  This is an area of frequent breakage because the
kernel changes so fast.  But 2.6.9 + 1.0.7 does works fine for me as
modules, so this should be easy to fix...

-- 
Lee Revell <rlrevell@joe-job.com>



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
