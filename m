From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: AFMT_AC3 support
Date: Wed, 17 Dec 2003 23:04:10 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FE0E0EA.4060302@superbug.demon.co.uk>
References: <92C0412E07F63549B2A2F2345D3DB515F7D31D@cm-msg-02.cmedia.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <92C0412E07F63549B2A2F2345D3DB515F7D31D@cm-msg-02.cmedia.com.tw>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: =?windows-1252?Q?=22C=2EL=2E_Tien_-_=3F=3F=3F=22?= <cltien@cmedia.com.tw>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

C.L. Tien - ??? wrote:
> Hi,
> 
> Can ALSA support AFMT_AC3 to enable xine to play AC3 through S/PDIF interface? I check in core/pcm.c and core/oss/pcm_oss.c, neither of them has keywork AC3.
> 
> Sincerely,
> ChenLi Tien
> 
It works if you use the ALSA API instead of the OSS emulation in the 
ALSA driver.



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
