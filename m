From: =?iso-8859-1?Q?J=F6rn?= Nettingsmeier <nettings@folkwang-hochschule.de>
Subject: (long !) powermac support does not compile in current cvs
Date: Thu, 07 Feb 2002 11:25:50 +0100
Message-ID: <3C62562E.1A90D210@folkwang-hochschule.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: "alsa-devel@lists.sourceforge.net" <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

i'm not quite sure what's happening here...
it's a fresh checkout from 1030 MET.

need to go to my cs classes now, so i can't look into it further,
but i thought you might be interested.
i'll look into it further on saturday.



here's the output from the moment it goes haywire:


In file included from ../alsa-kernel/ppc/pmac.h:25,
                 from ../alsa-kernel/ppc/awacs.c:28,
                 from awacs.c:1:
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:41: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:41: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:42: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:42: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:43: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:43: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:61: parse
error before `snd_ctl_file_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:61: warning:
no semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:69: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:69: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:84: parse
error before `snd_card_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:84: warning:
no semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:93: parse
error before `}'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:97: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:99: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:101: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:101: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:103: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:103: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:103: warning:
type defaults to `int' in declaration of `snd_ctl_new_R524c8a5d'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:103: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:103: warning:
data definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:104: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:104: warning:
type defaults to `int' in declaration of `snd_ctl_new1_R5a00b9a8'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:104: warning:
data definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:105: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:105: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:106: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:106: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:107: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:107: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:108: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:108: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:109: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:109: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:110: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:110: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:110: warning:
type defaults to `int' in declaration of
`snd_ctl_find_numid_Re77acd4e'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:110: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:110: warning:
data definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:111: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:111: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:111: warning:
type defaults to `int' in declaration of `snd_ctl_find_id_R7bacce41'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:111: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:111: warning:
data definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:113: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:113: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:114: parse
error before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:114: warning:
function declaration isn't a prototype
In file included from
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:60,
                 from ../alsa-kernel/ppc/pmac.h:26,
                 from ../alsa-kernel/ppc/awacs.c:28,
                 from awacs.c:1:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:63: parse
error before `snd_pcm_substream_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:63: warning:
no semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:64: warning:
type defaults to `int' in declaration of `snd_pcm_oss_file_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:64: warning:
data definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:69: parse
error before `snd_pcm_oss_file_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:69: warning:
no semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:70: warning:
type defaults to `int' in declaration of `snd_pcm_oss_substream_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:70: warning:
data definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:75: parse
error before `snd_info_entry_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:75: warning:
no semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:76: warning:
type defaults to `int' in declaration of `snd_pcm_oss_stream_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm_oss.h:76: warning:
data definition has no type or storage class
In file included from ../alsa-kernel/ppc/pmac.h:26,
                 from ../alsa-kernel/ppc/awacs.c:28,
                 from awacs.c:1:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:84: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:84: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:85: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:85: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:86: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:87: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:88: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:88: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:89: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:89: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:90: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:90: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:91: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:91: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:92: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:92: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:93: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:94: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:95: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:96: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:200: parse error
before `snd_pcm_substream_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:200: warning: no
semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:202: parse error
before `}'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:220: parse error
before `snd_interval_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:220: warning: no
semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:225: parse error
before `}'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:225: warning: type
defaults to `int' in declaration of `snd_pcm_hw_constraints_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:225: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:227: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:229: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`constrs_mask':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:230: `constrs'
undeclared (first use in this function)
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:230: (Each
undeclared identifier is reported only once
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:230: for each
function it appears in.)
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:230: `var'
undeclared (first use in this function)
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:231: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:233: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:233: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:235: warning:
return-type defaults to `int'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:235: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`constrs_interval':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:236: `constrs'
undeclared (first use in this function)
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:236: `var'
undeclared (first use in this function)
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:237: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:267: parse error
before `snd_pcm_substream_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:267: warning: no
semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:268: warning: type
defaults to `int' in declaration of `trigger_tstamp'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:268: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:288: conflicting
types for `info'
/usr/src/alsa-cvs/alsa-driver/include/sound/control.h:64: previous
declaration of `info'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:326: parse error
before `hw_constraints'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:326: warning: type
defaults to `int' in declaration of `hw_constraints'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:326: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:329: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:329: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:330: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:330: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:344: parse error
before `}'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:347: parse error
before `snd_pcm_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:347: warning: no
semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:348: warning: type
defaults to `int' in declaration of `pstr'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:348: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:354: conflicting
types for `dma_area'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:336: previous
declaration of `dma_area'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:356: conflicting
types for `dma_bytes'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:338: previous
declaration of `dma_bytes'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:364: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:364: warning: type
defaults to `int' in declaration of `timer'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:364: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:368: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:368: warning: type
defaults to `int' in declaration of `next'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:368: conflicting
types for `next'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:201: previous
declaration of `next'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:368: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:370: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:370: warning: type
defaults to `int' in declaration of `link_next'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:370: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:371: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:371: warning: type
defaults to `int' in declaration of `link_prev'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:371: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:376: parse error
before `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:376: warning: type
defaults to `int' in declaration of `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:376: conflicting
types for `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:342: previous
declaration of `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:376: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:378: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:378: warning: type
defaults to `int' in declaration of `proc_root_R45fd8e5a'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:378: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:379: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:379: warning: type
defaults to `int' in declaration of `proc_info_entry'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:379: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:380: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:380: warning: type
defaults to `int' in declaration of `proc_hw_params_entry'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:380: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:381: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:381: warning: type
defaults to `int' in declaration of `proc_sw_params_entry'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:381: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:382: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:382: warning: type
defaults to `int' in declaration of `proc_status_entry'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:382: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:383: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:383: warning: type
defaults to `int' in declaration of `proc_prealloc_entry'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:383: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:384: parse error
before `}'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:395: parse error
before `snd_pcm_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:395: warning: no
semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:399: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:399: warning: type
defaults to `int' in declaration of `substream'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:399: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:402: parse error
before `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:402: warning: type
defaults to `int' in declaration of `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:402: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:405: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:405: warning: type
defaults to `int' in declaration of `reg'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:405: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:406: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:406: warning: type
defaults to `int' in declaration of `proc_root_R45fd8e5a'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:406: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:407: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:407: warning: type
defaults to `int' in declaration of `proc_info_entry'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:407: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:408: parse error
before `}'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:411: parse error
before `snd_card_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:411: warning: no
semicolon at end of struct or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:417: conflicting
types for `name'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:350: previous
declaration of `name'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:418: parse error
before `streams'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:418: warning: type
defaults to `int' in declaration of `streams'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:418: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:422: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:422: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:424: conflicting
types for `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:402: previous
declaration of `oss'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:426: parse error
before `}'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:429: parse error
before `snd_pcm_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:429: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:430: parse error
before `snd_pcm_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:430: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:438: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:438: warning: type
defaults to `int' in declaration of `snd_pcm_devices_Rbf7b81bd'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:438: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:439: parse error
before `snd_pcm_reg'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:439: warning: type
defaults to `int' in declaration of `snd_pcm_reg'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:439: warning: data
definition has no type or storage class
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:443: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:445: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:453: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:453: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:454: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:454: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:455: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:455: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:456: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:456: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:457: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:457: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:458: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:458: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:460: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:460: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:461: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:461: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:463: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:463: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:464: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:464: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:465: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:465: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:470: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:470: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:471: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:471: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:473: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:473: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:553: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:554: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_running':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:555: request for
member `runtime' in something not a structure or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:556: request for
member `runtime' in something not a structure or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:557: request for
member `stream' in something not a structure or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:558: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`bytes_to_samples':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:562: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:563: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`bytes_to_frames':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:567: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:568: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`samples_to_bytes':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:572: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:573: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`frames_to_bytes':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:577: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:578: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`frame_aligned':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:582: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:583: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:585: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:586: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_lib_buffer_bytes_R829805d2':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:587: request for
member `runtime' in something not a structure or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:588: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:591: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:592: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_lib_period_bytes_Ra3231f84':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:593: request for
member `runtime' in something not a structure or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:594: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_playback_avail':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:602: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:602: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:602: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:604: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:605: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:606: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_capture_avail':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:615: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:615: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:617: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_playback_hw_avail':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:623: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:624: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_capture_hw_avail':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:628: dereferencing
pointer to incomplete type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:629: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:631: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:633: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`snd_pcm_trigger_done':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:634: request for
member `runtime' in something not a structure or union
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:634: `master'
undeclared (first use in this function)
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:658: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:660: warning:
return-type defaults to `int'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`hw_param_interval':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:661: warning:
return from incompatible pointer type
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:670: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:672: warning:
return-type defaults to `int'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: In function
`hw_param_interval_c':
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:673: parse error
before `snd_interval_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:674: warning:
control reaches end of non-void function
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:689: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:689: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:690: warning: type
defaults to `int' in declaration of `snd_interval_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:690: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:690: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:691: warning: type
defaults to `int' in declaration of `snd_interval_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:691: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:691: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:692: warning: type
defaults to `int' in declaration of `snd_interval_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:692: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:693: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:694: warning: type
defaults to `int' in declaration of `snd_interval_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:694: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:695: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:696: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:696: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:697: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:697: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:698: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:700: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:701: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:703: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:707: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:710: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:711: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:714: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:715: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:717: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:718: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:720: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:721: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:723: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:724: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:727: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:728: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:728: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:730: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:730: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:732: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:732: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:733: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:733: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:778: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:778: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:779: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:779: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:780: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:780: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:781: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:782: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:783: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:783: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:784: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:784: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:785: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:785: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:786: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:786: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:787: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:787: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:788: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:788: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:789: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:789: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:790: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:790: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:791: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:791: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:792: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:792: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:793: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:793: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:794: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:794: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:795: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:795: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:796: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:796: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:797: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:797: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:798: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:798: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:799: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:799: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:800: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:801: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:802: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:803: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:804: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:805: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:806: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:807: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:813: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:813: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:814: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:814: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:815: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:815: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:821: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:821: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:822: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:822: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:823: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:823: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:824: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:824: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:826: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:828: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:829: parse error
before `*'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:831: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:834: parse error
before `snd_pcm_substream_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:835: warning:
function declaration isn't a prototype
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:837: parse error
before `snd_pcm_t'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:839: warning:
function declaration isn't a prototype
In file included from ../alsa-kernel/ppc/awacs.c:28,
                 from awacs.c:1:
../alsa-kernel/ppc/pmac.h:91: parse error before
`snd_pcm_substream_t'
../alsa-kernel/ppc/pmac.h:91: warning: no semicolon at end of struct
or union
../alsa-kernel/ppc/pmac.h:95: parse error before `}'
../alsa-kernel/ppc/pmac.h:112: parse error before `snd_kcontrol_t'
../alsa-kernel/ppc/pmac.h:112: warning: no semicolon at end of
struct or union
../alsa-kernel/ppc/pmac.h:124: parse error before `snd_card_t'
../alsa-kernel/ppc/pmac.h:124: warning: no semicolon at end of
struct or union
../alsa-kernel/ppc/pmac.h:133: parse error before `:'
../alsa-kernel/ppc/pmac.h:134: parse error before `:'
../alsa-kernel/ppc/pmac.h:135: parse error before `:'
../alsa-kernel/ppc/pmac.h:137: parse error before `:'
../alsa-kernel/ppc/pmac.h:138: parse error before `:'
../alsa-kernel/ppc/pmac.h:139: parse error before `:'
../alsa-kernel/ppc/pmac.h:146: parse error before `:'
../alsa-kernel/ppc/pmac.h:147: parse error before `:'
../alsa-kernel/ppc/pmac.h:155: conflicting types for `format'
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:276: previous
declaration of `format'
../alsa-kernel/ppc/pmac.h:171: parse error before `*'
../alsa-kernel/ppc/pmac.h:171: warning: type defaults to `int' in
declaration of `pcm'
../alsa-kernel/ppc/pmac.h:171: warning: data definition has no type
or storage class
../alsa-kernel/ppc/pmac.h:185: parse error before `:'
../alsa-kernel/ppc/pmac.h:190: parse error before `}'
../alsa-kernel/ppc/pmac.h:194: parse error before `*'
../alsa-kernel/ppc/pmac.h:194: warning: function declaration isn't a
prototype
In file included from awacs.c:1:
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_write':
../alsa-kernel/ppc/awacs.c:41: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:44: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:46: warning: implicit declaration of
function `snd_printd'
../alsa-kernel/ppc/awacs.c:50: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:50: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_write_reg':
../alsa-kernel/ppc/awacs.c:57: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: In function `screamer_recalibrate':
../alsa-kernel/ppc/awacs.c:73: warning: implicit declaration of
function `mdelay'
../alsa-kernel/ppc/awacs.c:75: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:77: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_set_format':
../alsa-kernel/ppc/awacs.c:87: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:88: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:88: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:89: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: At top level:
../alsa-kernel/ppc/awacs.c:136: parse error before `*'
../alsa-kernel/ppc/awacs.c:137: warning: function declaration isn't
a prototype
../alsa-kernel/ppc/awacs.c: In function
`snd_pmac_awacs_info_volume':
../alsa-kernel/ppc/awacs.c:138: `uinfo' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c: At top level:
../alsa-kernel/ppc/awacs.c:145: parse error before `*'
../alsa-kernel/ppc/awacs.c:146: warning: function declaration isn't
a prototype
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_get_volume':
../alsa-kernel/ppc/awacs.c:147: `kcontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:152: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:153: `ucontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:153: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:154: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: At top level:
../alsa-kernel/ppc/awacs.c:159: parse error before `*'
../alsa-kernel/ppc/awacs.c:160: warning: function declaration isn't
a prototype
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_put_volume':
../alsa-kernel/ppc/awacs.c:161: `kcontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:167: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:168: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:170: `ucontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:164: warning: `oldval' might be used
uninitialized in this function
../alsa-kernel/ppc/awacs.c: At top level:
../alsa-kernel/ppc/awacs.c:188: parse error before `*'
../alsa-kernel/ppc/awacs.c:189: warning: function declaration isn't
a prototype
../alsa-kernel/ppc/awacs.c: In function
`snd_pmac_awacs_info_switch':
../alsa-kernel/ppc/awacs.c:190: `uinfo' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c: At top level:
../alsa-kernel/ppc/awacs.c:197: parse error before `*'
../alsa-kernel/ppc/awacs.c:198: warning: function declaration isn't
a prototype
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_get_switch':
../alsa-kernel/ppc/awacs.c:199: `kcontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:203: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:204: `ucontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:204: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: At top level:
../alsa-kernel/ppc/awacs.c:209: parse error before `*'
../alsa-kernel/ppc/awacs.c:210: warning: function declaration isn't
a prototype
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_put_switch':
../alsa-kernel/ppc/awacs.c:211: `kcontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:216: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:217: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:218: `ucontrol' undeclared (first use in
this function)
../alsa-kernel/ppc/awacs.c:221: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:213: warning: `val' might be used
uninitialized in this function
../alsa-kernel/ppc/awacs.c:213: warning: `changed' might be used
uninitialized in this function
../alsa-kernel/ppc/awacs.c: In function `build_mixers':
../alsa-kernel/ppc/awacs.c:312: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_resume':
../alsa-kernel/ppc/awacs.c:321: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:322: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:323: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:324: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:325: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:326: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:327: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:328: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c: In function `snd_pmac_awacs_init':
../alsa-kernel/ppc/awacs.c:344: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:345: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:345: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:347: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:348: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:349: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:354: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:361: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:364: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:364: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:365: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:366: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:367: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:387: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:412: dereferencing pointer to incomplete
type
../alsa-kernel/ppc/awacs.c:414: dereferencing pointer to incomplete
type
awacs.c: At top level:
/usr/src/alsa-cvs/alsa-driver/include/sound/pcm.h:438: warning:
array `snd_pcm_devices_Rbf7b81bd' assumed to have one element
../alsa-kernel/ppc/pmac.h:164: storage size of `playback' isn't
known
../alsa-kernel/ppc/pmac.h:165: storage size of `capture' isn't known
make[1]: *** [awacs.o] Error 1
make[1]: Leaving directory `/usr/src/alsa-cvs/alsa-driver/ppc'
-- 
Jörn Nettingsmeier     
home://Kurfürstenstr.49.45138.Essen.Germany      
phone://+49.201.491621
http://spunk.dnsalias.org
http://www.linuxdj.com/audio/lad/

_______________________________________________
Alsa-devel mailing list
Alsa-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/alsa-devel
