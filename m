From: kbuild test robot <fengguang.wu@intel.com>
Subject: [asoc:topic/topology 104/105]
 sound/soc/soc-topology.c:1672:45: sparse: restricted __le32 degrades to
 integer
Date: Thu, 4 Jun 2015 18:30:47 +0800
Message-ID: <201506041842.qOqZ8I7Y%fengguang.wu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
 by alsa0.perex.cz (Postfix) with ESMTP id 3F560265E0D
 for <alsa-devel@alsa-project.org>; Thu,  4 Jun 2015 12:31:09 +0200 (CEST)
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: alsa-devel@alsa-project.org, Mark Brown <broonie@kernel.org>, kbuild-all@01.org
List-Id: alsa-devel@alsa-project.org

tree:   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/topology
head:   932ae8809469770a07ce19d6967d2ce303befa08
commit: 8a9782346dccd82cf912552735bda619de4efd8c [104/105] ASoC: topology: Add topology core
reproduce:
  # apt-get install sparse
  git checkout 8a9782346dccd82cf912552735bda619de4efd8c
  make ARCH=x86_64 allmodconfig
  make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> sound/soc/soc-topology.c:1672:45: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:189:28: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:190:39: sparse: incorrect type in return expression (different base types)
   sound/soc/soc-topology.c:190:39:    expected int
   sound/soc/soc-topology.c:190:39:    got restricted __le32 [usertype] reg
   sound/soc/soc-topology.c:202:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:203:39: sparse: incorrect type in return expression (different base types)
   sound/soc/soc-topology.c:203:39:    expected int
   sound/soc/soc-topology.c:203:39:    got restricted __le32 [usertype] shift
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:227:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:247:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:247:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:247:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:247:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:247:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:247:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:247:20: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:518:42: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:520:42: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:522:42: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:533:61: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:535:61: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:537:61: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:601:20: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:601:20:    expected unsigned int [unsigned] numid
   sound/soc/soc-topology.c:601:20:    got restricted __le32 [usertype] numid
>> sound/soc/soc-topology.c:602:21: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:602:21:    expected unsigned int [unsigned] length
   sound/soc/soc-topology.c:602:21:    got restricted __le32 [usertype] size
>> sound/soc/soc-topology.c:603:9: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:603:9:    expected unsigned long [unsigned] [usertype] len
   sound/soc/soc-topology.c:603:9:    got restricted __le32 [usertype] size
   sound/soc/soc-topology.c:644:33: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:654:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:654:27:    expected unsigned int [unsigned] [addressable] [assigned] access
   sound/soc/soc-topology.c:654:27:    got restricted __le32 [usertype] access
>> sound/soc/soc-topology.c:656:26: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:656:26:    expected int [signed] max
   sound/soc/soc-topology.c:656:26:    got restricted __le32 [usertype] max
   sound/soc/soc-topology.c:725:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:735:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:735:27:    expected unsigned int [unsigned] [addressable] [assigned] access
   sound/soc/soc-topology.c:735:27:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:747:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:747:25:    expected int [signed] max
   sound/soc/soc-topology.c:747:25:    got restricted __le32 [usertype] max
>> sound/soc/soc-topology.c:748:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:748:25:    expected int [signed] min
   sound/soc/soc-topology.c:748:25:    got restricted __le32 [usertype] min
>> sound/soc/soc-topology.c:749:28: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:749:28:    expected unsigned int [unsigned] invert:1
   sound/soc/soc-topology.c:749:28:    got restricted __le32 [usertype] invert
>> sound/soc/soc-topology.c:750:34: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:750:34:    expected int [signed] platform_max
   sound/soc/soc-topology.c:750:34:    got restricted __le32 [usertype] platform_max
>> sound/soc/soc-topology.c:776:55: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:776:55:    expected unsigned int [unsigned] [usertype] tlv_size
   sound/soc/soc-topology.c:776:55:    got restricted __le32 [usertype] tlv_size
   sound/soc/soc-topology.c:801:44: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:805:27: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:832:15: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:836:27: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:840:9: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:864:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:882:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:882:27:    expected unsigned int [unsigned] [addressable] [assigned] access
   sound/soc/soc-topology.c:882:27:    got restricted __le32 [usertype] access
>> sound/soc/soc-topology.c:890:27: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:890:27:    expected unsigned int [unsigned] items
   sound/soc/soc-topology.c:890:27:    got restricted __le32 [usertype] items
>> sound/soc/soc-topology.c:891:26: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:891:26:    expected unsigned int [unsigned] mask
   sound/soc/soc-topology.c:891:26:    got restricted __le32 [usertype] mask
   sound/soc/soc-topology.c:897:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:897:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:897:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:897:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:897:36: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:971:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:971:45: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:978:28: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:990:60: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:990:60:    expected unsigned long [unsigned] [usertype] size
   sound/soc/soc-topology.c:990:60:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:997:59: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:997:59:    expected unsigned long [unsigned] [usertype] size
   sound/soc/soc-topology.c:997:59:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:1000:60: sparse: incorrect type in argument 3 (different base types)
   sound/soc/soc-topology.c:1000:60:    expected unsigned long [unsigned] [usertype] size
   sound/soc/soc-topology.c:1000:60:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:982:41: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:1017:24: sparse: incorrect type in initializer (different base types)
   sound/soc/soc-topology.c:1017:24:    expected int [signed] count
   sound/soc/soc-topology.c:1017:24:    got restricted __le32 [usertype] count
   sound/soc/soc-topology.c:1020:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1020:45: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:1026:27: sparse: incorrect type in argument 4 (different base types)
   sound/soc/soc-topology.c:1026:27:    expected unsigned long [unsigned] [usertype] bytes
   sound/soc/soc-topology.c:1026:27:    got restricted __le32 [usertype] payload_size
   sound/soc/soc-topology.c:1084:33: sparse: restricted __le32 degrades to integer
>> sound/soc/soc-topology.c:1097:30: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1097:30:    expected unsigned int [unsigned] access
   sound/soc/soc-topology.c:1097:30:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:1109:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1109:25:    expected int [signed] max
   sound/soc/soc-topology.c:1109:25:    got restricted __le32 [usertype] max
   sound/soc/soc-topology.c:1110:25: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1110:25:    expected int [signed] min
   sound/soc/soc-topology.c:1110:25:    got restricted __le32 [usertype] min
   sound/soc/soc-topology.c:1111:28: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1111:28:    expected unsigned int [unsigned] invert:1
   sound/soc/soc-topology.c:1111:28:    got restricted __le32 [usertype] invert
   sound/soc/soc-topology.c:1112:34: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1112:34:    expected int [signed] platform_max
   sound/soc/soc-topology.c:1112:34:    got restricted __le32 [usertype] platform_max
   sound/soc/soc-topology.c:1156:25: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1177:20: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1177:20:    expected unsigned int [unsigned] access
   sound/soc/soc-topology.c:1177:20:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:1184:19: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1184:19:    expected unsigned int [unsigned] items
   sound/soc/soc-topology.c:1184:19:    got restricted __le32 [usertype] items
   sound/soc/soc-topology.c:1185:18: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1185:18:    expected unsigned int [unsigned] mask
   sound/soc/soc-topology.c:1185:18:    got restricted __le32 [usertype] mask
   sound/soc/soc-topology.c:1188:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1188:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1188:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1188:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1188:28: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1236:27: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1271:33: sparse: restricted __le32 degrades to integer
   sound/soc/soc-topology.c:1281:30: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1281:30:    expected unsigned int [unsigned] access
   sound/soc/soc-topology.c:1281:30:    got restricted __le32 [usertype] access
   sound/soc/soc-topology.c:1283:26: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1283:26:    expected int [signed] max
   sound/soc/soc-topology.c:1283:26:    got restricted __le32 [usertype] max
>> sound/soc/soc-topology.c:1339:38: sparse: incorrect type in argument 1 (different base types)
   sound/soc/soc-topology.c:1339:38:    expected int [signed] tplg_type
   sound/soc/soc-topology.c:1339:38:    got restricted __le32 [usertype] id
>> sound/soc/soc-topology.c:1351:22: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1351:22:    expected int [signed] [addressable] [assigned] reg
   sound/soc/soc-topology.c:1351:22:    got restricted __le32 [usertype] reg
>> sound/soc/soc-topology.c:1352:24: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1352:24:    expected unsigned char [unsigned] [addressable] [assigned] shift
   sound/soc/soc-topology.c:1352:24:    got restricted __le32 [usertype] shift
>> sound/soc/soc-topology.c:1353:23: sparse: incorrect type in assignment (different base types)
   sound/soc/soc-topology.c:1353:23:    expected unsigned int [unsigned] [addressable] [assigned] mask
   sound/soc/soc-topology.c:1353:23:    got restricted __le32 [usertype] mask
>> sound/soc/soc-topology.c:1361:67: sparse: too many warnings

vim +1672 sound/soc/soc-topology.c

  1656	
  1657			while (!soc_tplg_is_eof(tplg)) {
  1658	
  1659				/* make sure header is valid before loading */
  1660				ret = soc_valid_header(tplg, hdr);
  1661				if (ret < 0)
  1662					return ret;
  1663				else if (ret == 0)
  1664					break;
  1665	
  1666				/* load the header object */
  1667				ret = soc_tplg_load_header(tplg, hdr);
  1668				if (ret < 0)
  1669					return ret;
  1670	
  1671				/* goto next header */
> 1672				tplg->hdr_pos += hdr->payload_size +
  1673					sizeof(struct snd_soc_tplg_hdr);
  1674				hdr = (struct snd_soc_tplg_hdr *)tplg->hdr_pos;
  1675			}
  1676	
  1677			/* next data type pass */
  1678			tplg->pass++;
  1679		}
  1680	

---
0-DAY kernel test infrastructure                Open Source Technology Center
http://lists.01.org/mailman/listinfo/kbuild                 Intel Corporation
